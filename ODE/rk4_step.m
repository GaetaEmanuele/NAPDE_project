function k = rk4_step(Y, t, M, A,c, F, delta,g,g_t,x,bd_cond)
        % split u and v
        u = Y(1:length(u0));
        v = Y(length(u0)+1:end);
        
        %Dirichlet non omogeneus bd
        ug = zeros(size(A,2),1);
        if isequal(bd_cond.field1,'Dirichlet')
            x = nodes(1);
            ug(1) = eval(g);
        elseif isequal(bd_cond.field2,'Dirichlet')
            x = nodes(end);
            ug(end) = eval(g);
        end
        ug = ug*g_t(t);
        u = u+ug;
        % Derivate
        du_dt = v;
        dv_dt = M \ (F(t) - c^2 * A * u) * delta^2;
        
        % Concatenation
        k = [du_dt; dv_dt];
end