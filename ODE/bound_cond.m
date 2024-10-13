function [Matrices,u_g] = bound_cond(Matrices,Dati,x_bd,L)
    
    %Dirichlet non homogeneus boundary condition
    ndof = length(Matrices.f);
    u_g = sparse(ndof,1);
    
    Fun = inline(Dati.bound_cond_space,'x');
    
    if x_bd == Dati.domain(1)
        u_g(1) = Fun(0);
    else
        u_g(end) = Fun(L);
    end

    A = Matrices.A;
    M = Matrices.M;
    Matrices.f = Matrices.f- (A+M)*u_g;

end