disp('------------------ METODO RUNGE KUTTA DE 4 ORDEN ------------------')

syms t y

fsyms = input('Ingrese la función de la ecuación diferencial (dy/dt=f(t,y)): ');
I = input('Ingrese el intervalo de aproximacion [a ,b]: ');
Y0=input(sprintf('Ingrese la condicion inicial Y(%d)=',I(1)));
h = input('Ingrese el valor de h: ');
Fsyms_Exacta = input('Ingrese la solución exacta: ');

a = I(1);
b = I(2);

n = round((b-a)/h);
T = linspace(a, b, n+1);

% Funciones numéricas (MUCHO más rápido)
f = matlabFunction(fsyms, 'Vars', [t y]);
F = matlabFunction(Fsyms_Exacta, 'Vars', t);

Y = zeros(1, n+1);
Error = zeros(1, n+1);

Y(1) = Y0;
F_Exacta = F(T);

fprintf('ti\t\t|k1\t\t\t\t\t|k2\t\t\t\t\t|k3\t\t\t\t\t|k4\t\t\t\t\t|Y(ti)\t\t\t\t|F(ti)\t\t\t\t|Error');
fprintf('\n%.4f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%e', ...
    T(1), 0, 0, 0, 0, double(Y(1)), double(F_Exacta(1)), 0);

for i = 1:n
    k1 = f(T(i), Y(i));
    k2 = f(T(i) + h/2, Y(i) + (h/2)*k1);
    k3 = f(T(i) + h/2, Y(i) + (h/2)*k2);
    k4 = f(T(i) + h,   Y(i) + h*k3);
    
    Y(i+1) = Y(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    
    Error(i+1) = abs(F_Exacta(i+1) - Y(i+1));

    fprintf('\n%.4f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%e', ...
        T(i+1), double(k1), double(k2), double(k3), double(k4), ...
        double(Y(i+1)), double(F_Exacta(i+1)), Error(i+1));
end

fprintf('\nResultado final:\n')
fprintf('Aproximado: y(%.4f) = %.15f\n', T(end), Y(end))
fprintf('Exacto:     y(%.4f) = %.15f\n', T(end), F_Exacta(end))
fprintf('Error:      %e\n', Error(end))

mate.verificar_solucion(fsyms, Fsyms_Exacta, Y0, a)