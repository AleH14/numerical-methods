function valorAproximado = Simpson_compuesto(f, a, b, n)
    syms x
    
    % Validación
    if mod(n,2) ~= 0
        error('Para Simpson compuesto, n debe ser PAR');
    end

    h = (b - a) / n;
    X = a:h:b;                 % nodos
    Fx = subs(f, x, X); % evaluar función

    % Coeficientes K: 1,4,2,4,...,2,4,1
    K = ones(1, n+1);
    for i = 2:n
        if mod(i,2) == 0
            K(i) = 4;
        else
            K(i) = 2;
        end
    end

    % Fórmula de Simpson compuesto
    valorAproximado = (h/3) * sum(K .* Fx);

    % Valor exacto
    valorExacto =int(f, x, a, b);

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

    fprintf('\n===== Tabla =====\n');
    fprintf('\n');
    fprintf('%-3s | %-20s | %-25s | %-3s | %-20s\n', ...
        'i','Xi','f(x)','K','Kf(Xi)');
    fprintf(repmat('-',1,85)); fprintf('\n');
    
    for i = 1:n+1
        fprintf('%-3d | %-20.15f | %-25.15f | %-3d | %-20.15f\n', ...
            i-1, double(X(i)), double(Fx(i)), K(i), double(K(i)*Fx(i)));
    end
end