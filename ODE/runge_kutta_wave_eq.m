function [U,V]=runge_kutta_wave_eq(Dati,Matrices,bd_cond,x,dependence,list_U ,list_V,t_hat,delta)
    % load the data from Matrices and Dati
    c = Dati.c; 
    M = Matrices.M; 
    A = Matrices.A;
    D = A;
    f = Matrices.f;
    %only if we want to use Sommerfeld bd
    if strcmp(bd_cond.field1,'Sommerfeld') || strcmp(bd_cond.field2,'Sommerfeld')
        D = Matrices.D;
    end
    T = 1; %T is equal 1 indeed RK is applied in K_i_hat so the maximum time is 1
    dt = Dati.dt; 
    
    % initialization
    t = 0:dt:T; % Vettore temporale
    num_steps = length(t);
    u0=zeros(length(x),1);
    v0=u0;
    % initial condition
    if sum(t_hat==0)>=2
        u0 = eval(Dati.initial_cond); 
        v0 = eval(Dati.initial_velocity); 
    else 
        [u0,v0] = impose_continuity(dependence,list_U,list_V,x);
    end
    Y = [u0; v0]; 

    % preallocation of the buffer
    U = zeros(length(u0), num_steps);
    V = zeros(length(v0), num_steps);
    
    % store the initial condition
    U(:,1) = u0;
    V(:,1) = v0;

    % Time forcing
    F = inline(Dati.force_time,'t'); 
    
    g = inline(Dati.boundary_cond,'x');
    g_t = inline(Dati.boundary_cond_time,'t');

    for n = 1:num_steps-1
        % actual time
        ti = t(n);
        Yi = Y(:,n);
        
        % evalution of the RK43 coffiecent
        k1 = rk4_step(Yi, ti, M, A, c, F,f,delta,g,g_t,x,bd_cond);
        k2 = rk4_step(Yi + 0.5 * dt * k1, ti + 0.5 * dt, M, A, c, F,f,delta,g,g_t,x,bd_cond);
        k3 = rk4_step(Yi + 0.5 * dt * k2, ti + 0.5 * dt, M, A, c, F,f,delta,g,g_t,x,bd_cond);
        k4 = rk4_step(Yi + dt * k3, ti + dt, M, A, c, F,f,delta,g,g_t,x,bd_cond);
        
        % update the solution
        Y(:,n+1) = Yi + (dt / 6) * (k1 + 2*k2 + 2*k3 + k4);
        

        % split u and v
        U(:,n+1) = Y(1:length(u0),n+1);
        V(:,n+1) = Y(length(u0)+1:end, n+1);
    end
   
end
