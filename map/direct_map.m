function [x,t] = direct_map(x_hat,t_hat,delta,h)
x = x_hat;
t = h + t_hat*delta;
end