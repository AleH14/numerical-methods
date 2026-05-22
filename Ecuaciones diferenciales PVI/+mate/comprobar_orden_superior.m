function comprobar_orden_superior(eq_strs, t0, tf, U0, U_rk4)
    disp(' ');
    disp('======================================================================');
    disp('            ANÁLISIS DE ERROR Y VERIFICACIÓN DE REDUCCIÓN             ');
    disp('======================================================================');

    orden = length(eq_strs); 
    
    fprintf('Escribe la ED de %der orden original.\n', orden);
    if orden == 4
        disp('Usa y, Dy, D2y, D3y, D4y. Ejemplo: D4y - D3y + 2*D2y - y == exp(t)');
    else
        disp('Usa y, Dy, D2y, D3y. Ejemplo: D3y + 2*D2y - Dy + y == exp(t)');
    end
    eq_orig_str = input('Ecuación Original: ', 's');

    disp('PROCESANDO SOLUCIÓN EXACTA...');

    % 1. Definir variables simbólicas (Definimos hasta u5 para estar seguros)
    syms t y(t) u1(t) u2(t) u3(t) u4(t) u5(t)
    
    % Creamos una lista de las variables para que el sistema las reconozca
    vars_list = {u1, u2, u3, u4, u5};
    sys_eqs = [];
    sys_conds = [];
    
    % 2. Construir el sistema (Ahora u2, u3, etc. ya existen antes del eval)
    for k = 1:orden
        % Construimos la ecuación: diff(uk, t) == expresión
        eq_actual = eval(['diff(u', num2str(k), ',t) == ', eq_strs{k}]);
        sys_eqs = [sys_eqs, eq_actual];
        
        % Construimos la condición inicial: uk(t0) == valor
        cond_actual = eval(['u', num2str(k), '(', num2str(t0), ') == ', num2str(U0(k))]);
        sys_conds = [sys_conds, cond_actual];
    end

    % 3. Resolver el sistema analíticamente
    try
        % Pasamos solo las variables que corresponden al orden actual
        sol = dsolve(sys_eqs, sys_conds);
    catch
        disp('ERROR: No se pudo resolver analíticamente el sistema reducido.');
        return;
    end

    U_real = zeros(1, orden);
    Errores = zeros(1, orden);
    
    % Obtenemos la solución de y(t) que siempre es u1
    U1_t = sol.u1; 

    disp(' ');
    disp('--- SOLUCIÓN ANALÍTICA EXACTA ---');
    fprintf('y(t)   = %s\n', char(U1_t));
    
    disp(' ');
    disp('--- COMPARATIVA EN T = b ---');
    fprintf('        %18s | %18s | %18s\n', 'Valor RK4', 'Valor Real', 'Error Absoluto');
    
    nombres_derivadas = {'y', 'Dy', 'D2y', 'D3y', 'D4y'}; 
    
    for k = 1:orden
        % Extraemos la solución de cada variable u_k
        u_sym_func = sol.(['u', num2str(k)]);
        U_real(k) = double(subs(u_sym_func, t, tf));
        Errores(k) = abs(U_real(k) - U_rk4(k));
        
        fprintf('%-7s(%.2f) | %18.10f | %18.10f | %18.4e\n', nombres_derivadas{k}, tf, U_rk4(k), U_real(k), Errores(k));
    end

    % 4. Comprobación en la ecuación original
    parts = strsplit(eq_orig_str, '==');
    if length(parts) == 2
        preparar = @(s) strrep(strrep(strrep(strrep(strrep(s, 'D5y', 'diff(y,t,5)'), 'D4y', 'diff(y,t,4)'), 'D3y', 'diff(y,t,3)'), 'D2y', 'diff(y,t,2)'), 'Dy', 'diff(y,t)');
        
        L_sym = eval(preparar(parts{1}));
        R_sym = eval(preparar(parts{2}));
        
        LHS = double(subs(subs(L_sym, y(t), U1_t), t, tf));
        RHS = double(subs(subs(R_sym, y(t), U1_t), t, tf));
        
        disp(' ');
        disp('--- COMPROBACIÓN FINAL EN ED ORIGINAL ---');
        fprintf('Lado Izquierdo: %.4f | Lado Derecho: %.4f\n', LHS, RHS);
        
        if abs(LHS - RHS) < 1e-4
            disp(' ¡ÉXITO! Tu reducción a sistema SATISFACE la ecuación diferencial original.');
        else
            disp(' ¡ADVERTENCIA! Los valores no coinciden. Revisa el despeje de la ED.');
        end
    else
        disp('ERROR: Formato de ecuación incorrecto (usa "==").');
    end
end