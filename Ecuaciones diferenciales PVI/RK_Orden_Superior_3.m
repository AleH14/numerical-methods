disp('------------------ METODO RUNGE KUTA 4 ECUACIONES DIFERENCIALES DE ORDEN SUPERIOR ------------------')

format long
syms t u1 u2 u3

fu1_syms = input('Du/dt (u1''): ');
fu2_syms = input('D2u/dt (u2''): ');
fu3_syms = input('D3u/dt (u3''): ');

% Guardamos las expresiones en texto para la comprobación final
str_fu1 = char(fu1_syms);
str_fu2 = char(fu2_syms);
str_fu3 = char(fu3_syms);

I = input('Ingrese el intervalo [a ,b]: ');
u10 = input('Ingrese la condición inicial U (y): ');
u20 = input('Ingrese la condición inicial dU (y''): ');
u30 = input('Ingrese la condición inicial d2U (y''''): ');
h = input('Ingrese el valor de h: ');

a = I(1);
b = I(2);

n = round((b-a)/h);
T = linspace(a, b, n+1);

f1 = matlabFunction(fu1_syms, 'Vars', [t u1 u2 u3]);
f2 = matlabFunction(fu2_syms, 'Vars', [t u1 u2 u3]);
f3 = matlabFunction(fu3_syms, 'Vars', [t u1 u2 u3]);

U1 = zeros(1, n+1);
U2 = zeros(1, n+1);
U3 = zeros(1, n+1);

U1(1) = u10;
U2(1) = u20;
U3(1) = u30;

for i = 1:n
    % RK4 cálculos con punto y coma para no ensuciar consola
    k11 = f1(T(i), U1(i), U2(i), U3(i));
    k12 = f2(T(i), U1(i), U2(i), U3(i));
    k13 = f3(T(i), U1(i), U2(i), U3(i));

    k21 = f1(T(i)+h/2, U1(i)+(h/2)*k11, U2(i)+(h/2)*k12, U3(i)+(h/2)*k13);
    k22 = f2(T(i)+h/2, U1(i)+(h/2)*k11, U2(i)+(h/2)*k12, U3(i)+(h/2)*k13);
    k23 = f3(T(i)+h/2, U1(i)+(h/2)*k11, U2(i)+(h/2)*k12, U3(i)+(h/2)*k13);

    k31 = f1(T(i)+h/2, U1(i)+(h/2)*k21, U2(i)+(h/2)*k22, U3(i)+(h/2)*k23);
    k32 = f2(T(i)+h/2, U1(i)+(h/2)*k21, U2(i)+(h/2)*k22, U3(i)+(h/2)*k23);
    k33 = f3(T(i)+h/2, U1(i)+(h/2)*k21, U2(i)+(h/2)*k22, U3(i)+(h/2)*k23);

    k41 = f1(T(i)+h, U1(i)+h*k31, U2(i)+h*k32, U3(i)+h*k33);
    k42 = f2(T(i)+h, U1(i)+h*k31, U2(i)+h*k32, U3(i)+h*k33);
    k43 = f3(T(i)+h, U1(i)+h*k31, U2(i)+h*k32, U3(i)+h*k33);

    % Actualización
    U1(i+1) = U1(i) + (h/6)*(k11 + 2*k21 + 2*k31 + k41);
    U2(i+1) = U2(i) + (h/6)*(k12 + 2*k22 + 2*k32 + k42);
    U3(i+1) = U3(i) + (h/6)*(k13 + 2*k23 + 2*k33 + k43);

    % =========================================================
    % IMPRESIÓN ORDENADA DE LOS VALORES K Y RESULTADOS
    % =========================================================
    fprintf('\n[+] Iteración %d | Avanzando desde t = %.4f hacia t = %.4f\n', i, T(i), T(i+1));
    fprintf('    %-15s %-15s %-15s\n', 'Var U1 (y)', 'Var U2 (y'')', 'Var U3 (y'''')');
    fprintf('    --------------------------------------------------\n');
    fprintf('    k1 = %-10.6f k1 = %-10.6f k1 = %-10.6f\n', k11, k12, k13);
    fprintf('    k2 = %-10.6f k2 = %-10.6f k2 = %-10.6f\n', k21, k22, k23);
    fprintf('    k3 = %-10.6f k3 = %-10.6f k3 = %-10.6f\n', k31, k32, k33);
    fprintf('    k4 = %-10.6f k4 = %-10.6f k4 = %-10.6f\n', k41, k42, k43);
    fprintf('    --------------------------------------------------\n');
    fprintf('    y   = %-12.8f\n', U1(i+1));
    fprintf('    Dy  = %-12.8f\n', U2(i+1));
    fprintf('    D2y = %-12.8f\n', U3(i+1));
end

disp(' ');
disp('--- RESULTADO FINAL APROXIMADO (RK4) ---');
fprintf('y(%.4f)   = %.15f\n', T(end), U1(end));
fprintf('Dy(%.4f)  = %.15f\n', T(end), U2(end));
fprintf('D2y(%.4f) = %.15f\n', T(end), U3(end));


% Llamada a la función externa de comprobación (UNIVERSAL)
ecuaciones_str = {str_fu1, str_fu2, str_fu3};
condiciones_iniciales = [u10, u20, u30];
resultados_rk4 = [U1(end), U2(end), U3(end)];

mate.comprobar_orden_superior(ecuaciones_str, a, b, condiciones_iniciales, resultados_rk4);