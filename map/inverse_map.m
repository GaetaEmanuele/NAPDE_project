function [x_hat,t_hat] = inverse_map(x,t,delta,h)
x_hat = x;
t_hat = (t-h)/delta;
end