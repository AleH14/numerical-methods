function verificar_solucion(f, y_sol, Y0, t0)

    syms t y

    fprintf('\n------------------ VERIFICACION ------------------\n')

    % Derivada de la solución propuesta
    dy = diff(y_sol, t);

    % Sustituir correctamente y -> y_sol(t)
    f_eval = subs(f, y, y_sol);

    % Diferencia simbólica
    resultado = simplify(dy - f_eval);

    % ===============================
    % 1. VERIFICACION SIMBOLICA
    % ===============================
    if isequal(resultado, sym(0))
        disp('Solución correcta (verificación simbólica exacta)')
        es_correcta = true;
    else
        % ===============================
        % 2. VERIFICACION NUMERICA (fallback)
        % ===============================
        puntos = linspace(t0, t0 + 5, 5); % puntos de prueba
        errores = zeros(size(puntos));

        for i = 1:length(puntos)
            val = double(subs(resultado, t, puntos(i)));
            errores(i) = abs(val);
        end

        if all(errores < 1e-6)
            disp(' Solución probablemente correcta (verificación numérica)')
            es_correcta = true;
        else
            disp(' La solución NO satisface la ecuación diferencial')
            disp('Error simbólico:')
            pretty(resultado)
            es_correcta = false;
        end
    end

    % ===============================
    % 3. VERIFICAR CONDICION INICIAL
    % ===============================
    y0_eval = double(subs(y_sol, t, t0));

    if abs(y0_eval - Y0) < 1e-6
        disp(' Cumple condición inicial')
    else
        disp(' No cumple condición inicial')
        fprintf('Esperado: %.6f | Obtenido: %.6f\n', Y0, y0_eval)
        es_correcta = false;
    end

    % ===============================
    % 4. RESULTADO FINAL
    % ===============================
    if es_correcta
        fprintf(' VERIFICACION COMPLETA EXITOSA\n')
    else
        fprintf('VERIFICACION FALLIDA\n')
    end

end