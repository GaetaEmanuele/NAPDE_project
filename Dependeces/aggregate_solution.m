function [index_x,index_t] = aggregate_solution(U,x_hat,t_hat,x0,h)
    %find the index of the present temporal index
    list_t = find(U==t_hat(0));
    couple = list_t{1};
    index_t = couple(2)+1;

    %index in space
    %default value for x otherwise we will have a definition on the if
    %scope
    x=0;
    if length(x_hat)>3
        %as convetion the space time node in a tent are enumerated
        %in anti orar 
        x = x_hat(4);
    else
        x = x_hat(3);
    end
    %the inverse formula of equispaced node
    index_x = (x-x0)/h;
end