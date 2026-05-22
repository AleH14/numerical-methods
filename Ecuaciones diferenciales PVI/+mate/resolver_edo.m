function resolver_edo(f, Y0, t0)

    syms y(t) t

    fprintf('\n------------------ ANALISIS EDO ------------------\n')

    % Construir ecuación diferencial
    ode = diff(y,t) == subs(f, 'y', y);

    % ===============================
    % 1. INTENTAR SOLUCION GENERAL
    % ===============================
    try
        sol_general = dsolve(ode);
        disp('?? Solución general encontrada:')
        pretty(sol_general)
    catch
        disp('? No se pudo encontrar solución general')
        sol_general = [];
    end

    % ===============================
    % 2. SOLUCION PARTICULAR
    % ===============================
    try
        cond = y(t0) == Y0;
        sol_particular = dsolve(ode, cond);
        disp('?? Solución particular:')
        pretty(sol_particular)
    catch
        disp('? No se pudo encontrar solución particular')
    end

    % ===============================
    % 3. CLASIFICACION (heurística)
    % ===============================
    fprintf('\nTipo de ecuación detectado:\n')

    f_s = char(f);

    if contains(f_s, 'y') && ~contains(f_s, 'diff')
        if contains(f_s, 'y^') || contains(f_s, 'y*y')
            disp('? No lineal')
        else
            disp('? Posiblemente lineal de primer orden')
        end
    end

    if contains(f_s, 't*y')
        disp('? Posible separable')
    end

    if contains(f_s, 'y/t') || contains(f_s, 't/y')
        disp('? Posible homogénea')
    end

end