function valorAproximado = gaussLegendre(f, a, b, n)
    syms x t
    
    % Polinomio de Legendre
    p = legendreP(n, x);
    dp = diff(p);
    
    % Transformación de [a,b] ? [-1,1]
    t_expr = 1/2*((b - a)*t + a + b);
    dt = (b - a)/2;
    ft = subs(f, x, t_expr) * dt;
    
    % Nodos (raíces)
    X = real(double(solve(p)));
    
    % Pesos
    W = zeros(n,1);
    for i = 1:n
        I = int(p/(x - X(i)), -1, 1, 'PrincipalValue', true);
        W(i) = double((subs(dp, x, X(i))^-1) * I);
    end
    
    % Aproximación
    Ft_eval = subs(ft, t, X);
    valorAproximado = sum(W .* Ft_eval);
    
    % Valor exacto
    valorExacto = int(f, x, a, b);
    
    % Errores
    err = abs(valorExacto - valorAproximado);
    
    if valorExacto ~= 0
        errorRelativo = (err / abs(valorExacto)) * 100;
    else
        errorRelativo = NaN;
    end
    
    % Resultados
    fprintf('\n===== RESULTADOS =====\n');
    fprintf('Valor aproximado: %.15f\n', double(valorAproximado));
    fprintf('Valor exacto: %.15f\n', double(valorExacto));
    fprintf('Error absoluto: %e\n', double(err));
    fprintf('Error relativo: %.9f%%\n\n', double(errorRelativo));
    
    % ? Tabla tipo manual
    fprintf('%-3s | %-20s | %-20s | %-20s\n', ...
        'i','Xi','Wi','Wi*f(ti)');
    fprintf(repmat('-',1,75)); fprintf('\n');
    
    for i = 1:n
        fprintf('%-3d | %-20.15f | %-20.15f | %-20.15f\n', ...
            i-1, double(X(i)), double(W(i)), double(W(i)*Ft_eval(i)));
    end
end