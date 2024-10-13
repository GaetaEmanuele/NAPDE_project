function Tent = StructTent(x_coordinate, t_higher)
    % Definition of the data structure of a single tent
    A = zeros(4,2);
    if length(t_higher)==3
        if length(x_coordinate)==2
            A(1:2,1) = x_coordinate;
            A(3,1) = x_coordinate(1);
        else
            A(1:3,1) = x_coordinate;
        end
        A(1:3,2) = t_higher;
        A(end,1) = -1;
        A(end,2) = -1;
    else
        A(1:3,1) = x_coordinate;
        A(:,2) = t_higher;
        A(end,1) = x_coordinate(end-1);
    end
    Tent = A;
end

