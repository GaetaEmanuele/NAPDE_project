function [Ui,Vi] = solver(Dati,bd_cond,dependence,U,V,x_hat,t_hat,delta)
%discritization in space
[Matrices,x]=C_matrix(Dati,min(x_hat),max(x_hat));

%solve ODE
[Ui,Vi] = runge_kutta_wave_eq(Dati,Matrices,bd_cond,x,dependence,U ,V,t_hat,delta);

end