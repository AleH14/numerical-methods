disp('------------------ METODO RUNGE KUTTA 4 ECUACIONES DIFERENCIALES DE ORDEN 4 ------------------')

format long
syms t u1 u2 u3 u4

fu1_syms = input('Du/dt (u1''): ');
fu2_syms = input('D2u/dt (u2''): ');
fu3_syms = input('D3u/dt (u3''): ');
fu4_syms = input('D4u/dt (u4''): ');

% Guardamos las expresiones en texto para la comprobación final
str_fu1 = char(fu1_syms);
str_fu2 = char(fu2_syms);
str_fu3 = char(fu3_syms);
str_fu4 = char(fu4_syms);

I = input('Ingrese el intervalo [a ,b]: ');
u10 = input('Ingrese la condición inicial U (y): ');
u20 = input('Ingrese la condición inicial dU (y''): ');
u30 = input('Ingrese la condición inicial d2U (y''''): ');
u40 = input('Ingrese la condición inicial d3U (y''''''): ');
h = input('Ingrese el valor de h: ');

a = I(1);
b = I(2);

n = round((b-a)/h);
T = linspace(a, b, n+1);

f1 = matlabFunction(fu1_syms, 'Vars', [t u1 u2 u3 u4]);
f2 = matlabFunction(fu2_syms, 'Vars', [t u1 u2 u3 u4]);
f3 = matlabFunction(fu3_syms, 'Vars', [t u1 u2 u3 u4]);
f4 = matlabFunction(fu4_syms, 'Vars', [t u1 u2 u3 u4]);

U1 = zeros(1, n+1);
U2 = zeros(1, n+1);
U3 = zeros(1, n+1);
U4 = zeros(1, n+1);

U1(1) = u10;
U2(1) = u20;
U3(1) = u30;
U4(1) = u40;

% =========================================================
% ENCABEZADO DE LA TABLA DE RESULTADOS
% =========================================================
disp(' ');
disp('=================================================================================================');
fprintf(' %-5s | %-8s | %-15s | %-15s | %-15s | %-15s\n', 'Iter', 't', 'y (U1)', 'Dy (U2)', 'D2y (U3)', 'D3y (U4)');
disp('-------------------------------------------------------------------------------------------------');
% Imprimir la condición inicial (Iteración 0)
fprintf(' %-5d | %-8.4f | %-15.8f | %-15.8f | %-15.8f | %-15.8f\n', 0, T(1), U1(1), U2(1), U3(1), U4(1));

for i = 1:n
    % RK4 cálculos con punto y coma para no ensuciar consola
    k11 = f1(T(i), U1(i), U2(i), U3(i), U4(i));
    k12 = f2(T(i), U1(i), U2(i), U3(i), U4(i));
    k13 = f3(T(i), U1(i), U2(i), U3(i), U4(i));
    k14 = f4(T(i), U1(i), U2(i), U3(i), U4(i));

    k21 = f1(T(i)+h/2, U1(i)+(h/2)*k11, U2(i)+(h/2)*k12, U3(i)+(h/2)*k13, U4(i)+(h/2)*k14);
    k22 = f2(T(i)+h/2, U1(i)+(h/2)*k11, U2(i)+(h/2)*k12, U3(i)+(h/2)*k13, U4(i)+(h/2)*k14);
    k23 = f3(T(i)+h/2, U1(i)+(h/2)*k11, U2(i)+(h/2)*k12, U3(i)+(h/2)*k13, U4(i)+(h/2)*k14);
    k24 = f4(T(i)+h/2, U1(i)+(h/2)*k11, U2(i)+(h/2)*k12, U3(i)+(h/2)*k13, U4(i)+(h/2)*k14);

    k31 = f1(T(i)+h/2, U1(i)+(h/2)*k21, U2(i)+(h/2)*k22, U3(i)+(h/2)*k23, U4(i)+(h/2)*k24);
    k32 = f2(T(i)+h/2, U1(i)+(h/2)*k21, U2(i)+(h/2)*k22, U3(i)+(h/2)*k23, U4(i)+(h/2)*k24);
    k33 = f3(T(i)+h/2, U1(i)+(h/2)*k21, U2(i)+(h/2)*k22, U3(i)+(h/2)*k23, U4(i)+(h/2)*k24);
    k34 = f4(T(i)+h/2, U1(i)+(h/2)*k21, U2(i)+(h/2)*k22, U3(i)+(h/2)*k23, U4(i)+(h/2)*k24);

    k41 = f1(T(i)+h, U1(i)+h*k31, U2(i)+h*k32, U3(i)+h*k33, U4(i)+h*k34);
    k42 = f2(T(i)+h, U1(i)+h*k31, U2(i)+h*k32, U3(i)+h*k33, U4(i)+h*k34);
    k43 = f3(T(i)+h, U1(i)+h*k31, U2(i)+h*k32, U3(i)+h*k33, U4(i)+h*k34);
    k44 = f4(T(i)+h, U1(i)+h*k31, U2(i)+h*k32, U3(i)+h*k33, U4(i)+h*k34);

    % Actualización
    U1(i+1) = U1(i) + (h/6)*(k11 + 2*k21 + 2*k31 + k41);
    U2(i+1) = U2(i) + (h/6)*(k12 + 2*k22 + 2*k32 + k42);
    U3(i+1) = U3(i) + (h/6)*(k13 + 2*k23 + 2*k33 + k43);
    U4(i+1) = U4(i) + (h/6)*(k14 + 2*k24 + 2*k34 + k44);

    % =========================================================
    % IMPRESIÓN ORDENADA EN FORMATO DE TABLA
    % =========================================================
    fprintf(' %-5d | %-8.4f | %-15.8f | %-15.8f | %-15.8f | %-15.8f\n', i, T(i+1), U1(i+1), U2(i+1), U3(i+1), U4(i+1));
end

disp('=================================================================================================');
disp(' ');
disp('--- RESULTADO FINAL APROXIMADO (RK4) ---');
fprintf('y(%.4f)   = %.15f\n', T(end), U1(end));
fprintf('Dy(%.4f)  = %.15f\n', T(end), U2(end));
fprintf('D2y(%.4f) = %.15f\n', T(end), U3(end));
fprintf('D3y(%.4f) = %.15f\n', T(end), U4(end));

% Empaquetamos en arreglos para enviar a la función universal
ecuaciones_str = {str_fu1, str_fu2, str_fu3, str_fu4};
condiciones_iniciales = [u10, u20, u30, u40];
resultados_rk4 = [U1(end), U2(end), U3(end), U4(end)];

% Llamada a la función externa de comprobación (UNIVERSAL)
mate.comprobar_orden_superior(ecuaciones_str, a, b, condiciones_iniciales, resultados_rk4);