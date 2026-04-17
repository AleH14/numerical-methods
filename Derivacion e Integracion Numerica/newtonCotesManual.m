function valorAproximado = newtonCotesManual(f, a, b, n)
    syms x
    
    % Pesos de Newton-Cotes seg�n el valor de n
    switch n
        case 1  % Trapecio
            factor = 1/2;
            W = [1, 1];
        case 2  % Simpson 1/3
            factor = 1/3;
            W = [1, 4, 1];
        case 3  % Simpson 3/8
            factor = 3/8;
            W = [1, 3, 3, 1];
        case 4
            factor = 2/45;
            W = [7, 32, 12, 32, 7];
        case 5
            factor = 5/288;
            W = [19, 75, 50, 50, 75, 19];
        case 6
            factor = 1/140;
            W = [41, 216, 27, 272, 27, 216, 41];
        otherwise
            error('Valor de n no soportado. Use n entre 1 y 6.');
    end
    
    % Mostrar los pesos utilizados
    fprintf('\n===== PESOS DE NEWTON-COTES (n = %d) =====\n', n);
    fprintf('Factor: %s\n', rats(factor));
    fprintf('W = [');
    fprintf('%d ', W);
    fprintf(']\n');
    
    h = (b - a) / n;
    
    X = a:h:b;             
    Fx = subs(f, x, X);
    
    % Aproximaci�n (aplicando el factor)
    valorAproximado = h * factor * sum(W .* Fx);
    
    % Valor exacto
    valorExacto = int(f, x, a, b);
    
    % Errores
    err = abs(valorExacto - valorAproximado);
    
    if valorExacto ~= 0
        errorRelativo = err / abs(valorExacto) * 100;
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
    fprintf('%-3s | %-20s | %-20s | %-10s | %-20s\n', ...
        'i','Xi','f(x)','Wi','Wi*f(Xi)');
    fprintf(repmat('-',1,85)); fprintf('\n');
    
    for i = 1:n+1
        fprintf('%-3d | %-20.15f | %-20.15f | %-10.6f | %-20.15f\n', ...
            i-1, double(X(i)), double(Fx(i)), double(W(i)), double(W(i)*Fx(i)));
    end
end