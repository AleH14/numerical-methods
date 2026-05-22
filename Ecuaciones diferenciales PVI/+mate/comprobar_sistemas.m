function comprobar_sistemas(str_fx, str_fy, t0, tf, x0, y0, X_rk4, Y_rk4)
    % Archivo: comprobar_sistemas.m
    disp(' ');
    disp('======================================================================');
    disp('            ANÁLISIS DE ERROR Y VERIFICACIÓN DEL SISTEMA              ');
    disp('======================================================================');

    % Pedir solo el sistema original
    eq_orig1_str = input('Ecuación Original 1 (ej: 3*Dx - x + 2*Dy + y == 24*exp(-t)): ', 's');
    eq_orig2_str = input('Ecuación Original 2 (ej: 6*Dx + 2*x + 4*Dy - 3*y == 0): ', 's');

    disp('PROCESANDO SOLUCIÓN EXACTA...');

    % 1. Definir variables simbólicas como funciones del tiempo
    syms t x(t) y(t)

    % 2. Construir las ecuaciones a partir de los textos recibidos del RK4
    eq_Dx = eval(['diff(x,t) == ', str_fx]);
    eq_Dy = eval(['diff(y,t) == ', str_fy]);

    cond_x = x(t0) == x0;
    cond_y = y(t0) == y0;

    % 3. Resolver analíticamente
    try
        sol = dsolve([eq_Dx, eq_Dy], [cond_x, cond_y]);
    catch
        disp('ERROR: No se pudo resolver analíticamente. Revisa tus reducciones.');
        return;
    end

    X_t = sol.x;
    Y_t = sol.y;

    % 4. Evaluar el valor exacto en el tiempo final (tf)
    X_real = double(subs(X_t, t, tf));
    Y_real = double(subs(Y_t, t, tf));

    % 5. Calcular el Error Absoluto contra RK4
    Error_X = abs(X_real - X_rk4);
    Error_Y = abs(Y_real - Y_rk4);

    disp(' ');
    disp('--- SOLUCIÓN ANALÍTICA EXACTA ENCONTRADA ---');
    fprintf('X(t) = %s\n', char(X_t));
    fprintf('Y(t) = %s\n', char(Y_t));

    disp(' ');
    disp('--- COMPARATIVA EN T = b ---');
    fprintf('        %18s | %18s | %18s\n', 'Valor RK4', 'Valor Real', 'Error Absoluto');
    fprintf('x(%.2f) | %18.10f | %18.10f | %18.4e\n', tf, X_rk4, X_real, Error_X);
    fprintf('y(%.2f) | %18.10f | %18.10f | %18.4e\n', tf, Y_rk4, Y_real, Error_Y);

    % 6. Comprobación del sistema original
    parts1 = strsplit(eq_orig1_str, '==');
    parts2 = strsplit(eq_orig2_str, '==');

    if length(parts1) == 2 && length(parts2) == 2
        % Preparamos los textos reemplazando Dx y Dy SIN funciones anónimas
        L1_str = strrep(strrep(parts1{1}, 'Dx', 'diff(x,t)'), 'Dy', 'diff(y,t)');
        R1_str = strrep(strrep(parts1{2}, 'Dx', 'diff(x,t)'), 'Dy', 'diff(y,t)');
        L2_str = strrep(strrep(parts2{1}, 'Dx', 'diff(x,t)'), 'Dy', 'diff(y,t)');
        R2_str = strrep(strrep(parts2{2}, 'Dx', 'diff(x,t)'), 'Dy', 'diff(y,t)');

        % Convertimos a formato simbólico con eval
        L1_sym = eval(L1_str);
        R1_sym = eval(R1_str);
        L2_sym = eval(L2_str);
        R2_sym = eval(R2_str);

        % Sustituimos x(t) e y(t) por las respuestas encontradas
        L1_sub = subs(L1_sym, [x(t), y(t)], [X_t, Y_t]);
        R1_sub = subs(R1_sym, [x(t), y(t)], [X_t, Y_t]);
        L2_sub = subs(L2_sym, [x(t), y(t)], [X_t, Y_t]);
        R2_sub = subs(R2_sym, [x(t), y(t)], [X_t, Y_t]);

        % Evaluamos numéricamente en el tiempo tf
        LHS1 = double(subs(L1_sub, t, tf));
        RHS1 = double(subs(R1_sub, t, tf));
        LHS2 = double(subs(L2_sub, t, tf));
        RHS2 = double(subs(R2_sub, t, tf));

        disp(' ');
        disp('--- COMPROBACIÓN FINAL EN SISTEMA ORIGINAL ---');
        fprintf('Eq1 -> Lado Izquierdo: %.4f | Lado Derecho: %.4f\n', LHS1, RHS1);
        fprintf('Eq2 -> Lado Izquierdo: %.4f | Lado Derecho: %.4f\n', LHS2, RHS2);

        tol = 1e-4; 
        disp(' ');
        if abs(LHS1 - RHS1) < tol && abs(LHS2 - RHS2) < tol
            disp(' ¡ÉXITO! Tu despeje/reducción SATISFACE el sistema original.');
        else
            disp(' ¡ADVERTENCIA! Los valores no coinciden. El sistema original no se cumple.');
        end
    else
        disp('ERROR al leer las ecuaciones originales. Asegúrate de incluir "==".');
    end
end