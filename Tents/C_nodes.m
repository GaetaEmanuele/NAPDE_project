function [nodes,n_even,n_odd] = C_nodes(x,T,c,N)
    Jodd = x(2:2:end);
    Jeven = x(1:2:end);
    n_even = fix(length(Jeven)/3) +1 ;
    n_odd = fix(length(Jeven)/3) +1 ;
    Nl = neib_nodes(x);
    MapOdd = @(t) 2*t;
    MapEven = @(t) 2*t -1;
    w = zeros(1,N);
    w_old = w;
    i=0;
    nodes = zeros(2,N);
    t0 = zeros(1,N);
    nodes(1,:) = x;
    nodes(2,:) = t0;
    while(any(w_old<T))
        if rem(i,2)==0
            J=Jeven;
            Map = MapEven;
        elseif rem(i,2)>0
            J=Jodd;
            Map = MapOdd;
        end
        index = Map(1:length(J));
        w = w + compute_advancing_front(J,Map,w_old,Nl,T,c,x);
        new_nodes = zeros(2,N);
        new_nodes(1,:) = x;
        new_nodes(2,:) = w;
        nodes = [nodes; w];
        w_old = w;
        
        i=i+1;
    end
end