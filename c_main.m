function [U,nodes] = c_main()

addpath Tents
addpath Plot
addpath map
addpath Dependeces
addpath ODE
addpath FEM_1D
addpath Solver

Dati  = C_dati();
%creation of the space-time meshes
[tents,nodes,tentDependencies] = create_tents(Dati);

%N = (Dati.domain(2)-Dati.domain(1))/Dati.h;
%x = linspace(Dati.domain(1),Dati.domain(2),N);
U = {};
V = {};
C_plot(nodes,Dati);
I_max = size(tents,1);
delta = zeros(1,I_max);
%solve the problem in each tent
Tent = zeros(4,2);
for i=1:I_max
    %selection of valid value since -1 is a defualt value 
    time = tents(i,:,2);
    x_ = tents(i,:,1);
    acceptable_x = x_(x_>-1);
    acceptable_time = time(time>=0);
    tau = min(acceptable_time);
    delta(i) = max(acceptable_time)-tau;
    
    %mapp the physical tent Ki into the simplest tent Ki_hat
    [x_hat,t_hat] = inverse_map(acceptable_x,acceptable_time,delta(i),tau);
    
    %solve the problem in Ki_hat
    bd_cond = check_bd_condition(acceptable_x,x_hat(1),x_hat(end));
    
    [U_hat_i,V_hat_i] = solver(Dati,bd_cond,tentDependencies(i,:,:),U,V,x_hat,t_hat);
    U{end} = U_hat_i;
    V{end} = V_hat_i;
    %map back the solution
end
end