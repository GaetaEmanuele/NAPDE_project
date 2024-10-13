function [Matrices,x]=C_matrix(Dati,x_0,x_1)
    x0 = x_0;
    x1 = x_1;
    x_temporary = x0:Dati.h:x1;
    tne = length(x_temporary)-1;
    [ ~, lnn, nln, el, connectivity, tnn, x ] = CreateMesh( Dati.element, tne, x0, x1);
    
    [basis] = shape_basis(Dati.element);

    [xq, W_1D] = Quadrature(nln);

    [dphiq,Deriv] = evalshape(basis,xq);

    A = sparse(tnn,tnn);
    M = sparse(tnn,tnn);
    f = sparse(tnn,1);
    nq = length(W_1D);
    BJ = Jacobian(xq,nq);

    % Initialization of Matrices
    Matrices.A = A;
    Matrices.M = M;
    Matrices.f = f;

    for ie=1:tne
        iglo = connectivity(1:nln,ie);

        K_loc = zeros(nln,nln);
        M_loc = zeros(nln,nln);
        f_loc = zeros(nln,1);
        fun = inline(Dati.force,'x');
        for q=1:nq
            B = BJ(q);
            for i=1:nln
                deriv_i = Deriv(q,i);
                phi_i = dphiq(q,i);
                x_q = xq(q); 
                f_loc(i) = f_loc(i) + (1/B)*fun(x_q)*phi_i*W_1D(q);
                for j=1:nln
                    deriv_j = Deriv(q,j);
                    phi_j = dphiq(q,j);
                    K_loc(i,j) = K_loc(i,j) + (1/B)*(deriv_j*deriv_i)*W_1D(q);
                    M_loc(i,j) = M_loc(i,j) + (1/B)*(phi_i*phi_j)*W_1D(q);
                end
            end
        end
        A(iglo,iglo) = A(iglo,iglo) + K_loc ;
        M(iglo,iglo) = M(iglo,iglo) + M_loc;
        f(iglo) = f(iglo) + f_loc;
    end
    % store the matrices
    Matrices.A = A;
    Matrices.M = M;
    Matrices.f = f;
end