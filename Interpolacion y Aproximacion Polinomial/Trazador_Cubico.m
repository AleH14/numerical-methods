disp('----------- TRAZADORES CUBICOS (NATURAL) -----------')
format long
syms x
aproximar = input('Ingrese el valor a aproximar: ');
X = input('Ingrese los nodos [x0 x1 x2 ... xn]: ');
opcion = input('¿Posee la funcion f(x)? [s/n]: ','s');
n = length(X);

if opcion == 's'
    f = input('Ingrese la funcion f(x): ');
    Y = double(subs(f, X));
elseif opcion == 'n'
    Y = input('Ingrese las imagenes [f(x0) ... f(xn)]: ');
else
    error('Opción no válida')
end

h = diff(X);
A = zeros(n);
B = zeros(n,1);

% Condiciones naturales
A(1,1) = 1;
A(n,n) = 1;

for i = 2:n-1
    A(i,i-1) = h(i-1);
    A(i,i)   = 2*(h(i-1) + h(i));
    A(i,i+1) = h(i);
    B(i) = 3*((Y(i+1)-Y(i))/h(i) - (Y(i)-Y(i-1))/h(i-1));
end

C = A\B;
b = zeros(n-1,1);
d = zeros(n-1,1);
for i = 1:n-1
    b(i) = (Y(i+1)-Y(i))/h(i) - h(i)*(2*C(i)+C(i+1))/3;
    d(i) = (C(i+1)-C(i))/(3*h(i));
end

k = find(aproximar >= X,1,'last');
k = min(k,n-1);

Polinomio = Y(k) ...
    + b(k)*(x - X(k)) ...
    + C(k)*(x - X(k))^2 ...
    + d(k)*(x - X(k))^3;

disp('Polinomio del intervalo correspondiente:')
pretty(vpa(Polinomio,9))

valorAprox = double(subs(Polinomio, x, aproximar));
fprintf('\nValor aproximado en x = %.4f es:\n', aproximar);
fprintf('%.9f\n', valorAprox);
if opcion == 's'
    valorExacto = double(subs(f, aproximar));
    errorAbs = abs(valorExacto - valorAprox);

    fprintf('Valor exacto:   %.9f\n', valorExacto);
    fprintf('Error absoluto: %e\n', errorAbs);
end