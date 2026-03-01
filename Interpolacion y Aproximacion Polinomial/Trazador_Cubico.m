disp('--------METODO DE TRAZADOR CUBICO-------');
syms x
format long
aproximar = input('Ingrese el valor a aproximar: ');
X = input('Ingrese los nodos [x0 x1 x2 ... xn]: ');
opcion = input('¿Posee la funcion f(x)? [s/n]: ','s');
n = length(X);

if opcion == 's'
    f = input('Ingrese la funcion f(x): ');
    Y = subs(f,X);
elseif opcion == 'n'
    Y = input('Ingrese las imagenes [f(x0) f(x1) f(x2) ... f(xn)]: ');
end

h = diff(X);
A = zeros(n);
B = zeros(n,1);

A(1,1) = 1;
A(n,n) = 1;
for i=2:n-1
    A(i,i-1) = h(i-1);
    A(i,i) = 2*(h(i-1) + h(i));
    A(i,i+1) = h(i);
    B(i) = 3*( (Y(i+1) - Y(i))/(h(i)) - (Y(i) - Y(i-1))/(h(i-1)) );
end

C= A\B;
b = zeros(n-1,1);
d = zeros(n-1,1);
for i = 1: n-1
    b(i) = (Y(i+1) - Y(i))/(h(i)) - (h(i)/3)*(2*C(i) + C(i+1)) ;
    d(i) = ( C(i + 1) - C(i))/( 3*h(i));
end

k = find(aproximar>=X,1,'last');
k = min(k,n-1);

Polinomio = Y(k) + b(k)*(x-X(k)) + C(k)*(x - X(k))^2 + d(k)*(x-X(k))^3;

fprintf('\nPolinomio Interpolador: \n')
pretty(vpa(Polinomio,9));

valorAproximado = subs(Polinomio,aproximar);
fprintf('\nEl valor aproximado es: %.9f\n',double(valorAproximado));

if opcion == 's'
    valorExacto = subs(f,aproximar);
    error = abs(valorExacto - valorAproximado);
    fprintf('\nEl valor Exacto es: %.9f\n',double(valorExacto));
    fprintf('\nEl error absoluto es: %e\n',double(error));
end