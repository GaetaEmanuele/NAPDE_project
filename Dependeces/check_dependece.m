function [index] = check_dependece(tent1,tent2)

t1 = tent1(:,2);
t2 = tent2(:,2);
[~, index_1] = intersect(t1(t1 > 0), t2(t2 > 0));
if ~isempty(index_1)
    % extract the single elemnt
    index = index_1(1);
else
    index = -1;
end

end