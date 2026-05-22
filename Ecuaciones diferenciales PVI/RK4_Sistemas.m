
disp('------------------ METODO RUNGE KUTA 4 SISTEMAS DE ECUACIONES DIFERENCIALES ------------------')

format long
syms t x y

fx_syms = input('Dx/dt: ');
fy_syms = input('Dy/dt: ');

% Convertimos la entrada simbólica a texto para enviarla a la función comprobador
str_fx = char(fx_syms);
str_fy = char(fy_syms);

I = input('Ingrese el intervalo [a ,b]: ');
x0 = input(sprintf('Ingrese la condición inicial x(%d)= ',double(I(1))));
y0 = input(sprintf('Ingrese la condición inicial y(%d)= ',double(I(1))));
h = input('Ingrese el valor de h: ');

a = I(1);
b = I(2);

n = round((b-a)/h);
T = linspace(a, b, n+1);

% Funciones numéricas
fx = matlabFunction(fx_syms, 'Vars', [t x y]);
fy = matlabFunction(fy_syms, 'Vars', [t x y]);

X = zeros(1, n+1);
Y = zeros(1, n+1);

X(1) = x0;
Y(1) = y0;

% Tabla inicial
% disp(' ');
% fprintf('%-10s | %-18s | %-18s\n', 't', 'x(t)', 'y(t)');
% fprintf('%s\n', repmat('-',1,55));
% fprintf('%-10.4f | %-18.15f | %-18.15f\n', T(1), X(1), Y(1));

for i = 1:n
    % RK4 sistema
    k11 = fx(T(i), X(i), Y(i));
    k12 = fy(T(i), X(i), Y(i));

    k21 = fx(T(i)+h/2, X(i)+(h/2)*k11, Y(i)+(h/2)*k12);
    k22 = fy(T(i)+h/2, X(i)+(h/2)*k11, Y(i)+(h/2)*k12);

    k31 = fx(T(i)+h/2, X(i)+(h/2)*k21, Y(i)+(h/2)*k22);
    k32 = fy(T(i)+h/2, X(i)+(h/2)*k21, Y(i)+(h/2)*k22);

    k41 = fx(T(i)+h, X(i)+h*k31, Y(i)+h*k32);
    k42 = fy(T(i)+h, X(i)+h*k31, Y(i)+h*k32);

    % Actualización
    X(i+1) = X(i) + (h/6)*(k11 + 2*k21 + 2*k31 + k41);
    Y(i+1) = Y(i) + (h/6)*(k12 + 2*k22 + 2*k32 + k42);
% =========================================================
    % IMPRESIÓN ORDENADA DE LOS VALORES K
    % =========================================================
    fprintf('\n[+] Iteración %d | Avanzando desde t = %.4f hacia t = %.4f\n', i, T(i), T(i+1));
    fprintf('    %-18s %-18s\n', 'Variable X', 'Variable Y');
    fprintf('    --------------------------------------\n');
    fprintf('    k1x = %-12.8f   k1y = %-12.8f\n', k11, k12);
    fprintf('    k2x = %-12.8f   k2y = %-12.8f\n', k21, k22);
    fprintf('    k3x = %-12.8f   k3y = %-12.8f\n', k31, k32);
    fprintf('    k4x = %-12.8f   k4y = %-12.8f\n', k41, k42);
    fprintf('    --------------------------------------\n');
    fprintf('    x(%.4f) = %-10.8f y(%.4f) = %-10.8f\n', T(i+1), X(i+1), T(i+1), Y(i+1));
end

disp(' ');
disp('--- RESULTADO APROXIMADO (RK4) ---');
fprintf('x(%.4f) = %.15f\n', T(end), X(end));
fprintf('y(%.4f) = %.15f\n', T(end), Y(end));

% ==========================================================
% LLAMADA A LA FUNCIÓN DE COMPROBACIÓN EXTERNA
% Le pasamos los textos de las derivadas, t inicial y final,
% condiciones iniciales y el resultado numérico de RK4.
% ==========================================================
mate.comprobar_sistemas(str_fx, str_fy, a, b, x0, y0, X(end), Y(end));