function D = derivadas_edo(f, n)
% DERIVADAS_EDO Devuelve derivadas sucesivas de una EDO y' = f(t,y)
%
% f : expresión simbólica f(t,y)
% n : número de derivadas a calcular
%
% D : celda con {y', y'', y''', ...}

    syms t y

    D = cell(1,n);

    % Primera derivada
    D{1} = simplify(f);

    % Generar derivadas sucesivas
    for k = 2:n
        D{k} = diff(D{k-1}, t) + diff(D{k-1}, y)*f;
        D{k} = simplify(D{k});
    end
    
    for k = 1:n
        fprintf('Derivada %d:\n', k);
        D{k}
    end
end