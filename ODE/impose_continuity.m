function [u0,v0] = impose_continuity(dependence,list_U,list_V,x)
    %select the tents
    index_tent = dependence;
    index_tent = index_tent(index_tent>0);
    U_selected = list_U(index_tent);
    V_selected = list_V(index_tent);
    u0 = zeros(1,length(x));
    v0 = zeros(1,length(x));
    %from x extract the medium indexes
    index = ceil(length(x)/2);
    %distiction between triangular and quadrilateral tents
    if length(U_selected)==2
        %aggragate the initial condition from the 2 tents
        U1 = U_selected{1};
        U2 = U_selected{2};
        V1 = V_selected{1};
        V2 = V_selected{2};
        u0 = [U1(index:end,end);U2(2:index,end)];
        v0 = [V1(index:end,end);V2(2:index,end)];
    else
        U = U_selected{1};
        V = V_selected{1};
        u0 = U(:,end);
        v0 = V(:,end);
    end
end