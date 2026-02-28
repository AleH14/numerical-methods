disp('----------METODO DE DIFERENCIAS DIVIDAS DE NEWTON-----------');
syms x
format long
aproximar = input('Ingrese el valor a aproximar: ');
X = input('Ingrese los nodos [x0 x1 x2 ... xn]: ');
opcion = input('¿Posee la funcion f(x)? [s/n]: ','s');
n = length(X);
F = zeros(n);

if opcion == 's'
    f = input('Ingrese la funcion f(x): ');
    Y = subs(f,X);
elseif opcion == 'n'
    Y = input('Ingrese las imagenes [f(x0) f(x1) f(x2) ... f(xn)]: ');
else
    error('Ingrese una opcion valida');
end

F(:,1) = Y(:);

for j =2:n
    for i=j:n
        F(i,j) = (F(i,j-1) - F(i-1,j-1))/( X(i) - X(i-j+1));
    end
end

Polinomio = F(1,1);
term =1;
for k=2:n
    term = term*(x - X(k-1));
    Polinomio = Polinomio + F(k,k)*term;
end

fprintf('\nMatriz de Diferencia Divididas: \n');
disp(F);
fprintf('\nPolinomio Interpolador: \n');
pretty(vpa(Polinomio,9));

valorAproximado = subs(Polinomio,aproximar);
fprintf('\nEl valor Aproximado es: %.9f\n',double(valorAproximado));

if opcion == 's'
    valorExacto  = subs(f,aproximar);
    fprintf('\nEl valor Exacto es: %.9f\n',double(valorExacto));
    error = abs(valorExacto - valorAproximado);
    fprintf('\nEl Error absoluto es: %e\n',double(error));
    
    
end