function k = rk4_step(Y, t, M, A,c, F,f, delta_rk,g,g_t,x,bd_cond)
        % split u and v
        u = Y(1:length(x));
        v = Y(length(x)+1:end);
        %Dirichlet non omogeneus bd
        ug = zeros(size(A,2),1);
        if isequal(bd_cond.field1,'Dirichlet')
            ug(1) = g(x(1));
        elseif isequal(bd_cond.field2,'Dirichlet')
            ug(end) = g(x(end));
        end
        ug = ug*g_t(t);
        u = u+ug;
        % Derivate
        du_dt = v;
        dv_dt = M \ (F(t)*f - c^2 * A * u) * delta_rk^2;
        
        % Concatenation
        k = [du_dt; dv_dt];
end