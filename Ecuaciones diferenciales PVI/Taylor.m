disp('------------------METODO DE TAYLOR------------------')
syms t y
f = input('Ingrese f(t,y): ');
I=input('Ingrese el intervalo de aproximacion [a ,b]: ');
Y0=input(sprintf('Ingrese la condicion inicial Y(%d)=',double(I(1))));
h = input('Ingrese h: ');
F_exacta = input('Ingrese la solución exacta: ');
nt = input('Ingrese el orden del método de Taylor: ');

a=I(1);
b=I(2);
Derivadas = sym(zeros(1, nt));
Derivadas(1) = f;

for i = 2:nt
    Derivadas(i) = input(['Ingrese la derivada #' num2str(i) ': ']);
end

%aqui construyo el polinomio de taylor
g = 0;
for i = 1:nt
    g = g + (h^i / factorial(i)) * Derivadas(i);
end


g_func = matlabFunction(g, 'Vars', [t y]);

n = round((b-a)/h);
T = linspace(a, b, n+1);

Y = zeros(1, n+1);
Y(1) = Y0;

F = double(subs(F_exacta, T));

fprintf('ti\t\t|Y(ti)\t\t\t\t|F(ti)\t\t\t\t|Error\n');
fprintf('%.4f\t|%.15f\t|%.15f\t|%e\n', T(1), Y(1), F(1), 0);
for i = 1:n
    Y(i+1) = Y(i) + g_func(T(i), Y(i));
    Error = abs(F(i+1) - Y(i+1));
    
    fprintf('%.4f\t|%.15f\t|%.15f\t|%e\n', T(i+1), Y(i+1), F(i+1), Error);
end

fprintf('\nAproximado: y(%.4f)=%.15f\n', T(end), Y(end));
fprintf('Exacto: F(%.4f)=%.15f\n', T(end), F(end));
fprintf('Error final: %e\n', Error);


mate.verificar_solucion(f, F_exacta, Y0, a)
mate.comprobar_derivadas_taylor(f, Derivadas, nt);