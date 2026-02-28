disp('-------------------METODO DE LAGRANGE-------------------')
syms x
format long
aproximar = input('Ingrese el valor a aproximar: ');
X = input('Ingrese los nodos [x0 x1 x2 ... xn]: ');
opcion = input('¿Posee la función f(x)? [s/n]:','s');
n = length(X);
L = sym(zeros(1,n));

if opcion == 's'
    f = input('Ingrese la funcion f(x): ');
    Y = subs(f,X);
elseif opcion == 'n'
    Y = input('Ingrese las imagenes [f(x0) f(x1) f(x2) ... f(xn)]: ');
else
    error('Ingrese una opcion valida');
end

for i=1:n
    numerador = 1;
    denominador = 1;
    for k = 1: n
        if k~=i
            numerador= numerador*(x -X(k));
            denominador = denominador*(X(i) - X(k));
        end
    end
    L(i) = numerador/denominador;
    fprintf('L%d(x) = \n',i-1);
    pretty(L(i));
end

Polinomio= sum(Y .* L);
fprintf('\nPolinomio de Lagrange: \n')
pretty(vpa(Polinomio,9));

ValorAproximado = double(subs(Polinomio,aproximar));
fprintf('\nEl valor aproximado es: %.9f\n',ValorAproximado);

if opcion == 's'
    ValorExacto = double(subs(f,aproximar));
    errorAbs = abs(ValorExacto - ValorAproximado);
    fprintf('\nEl Valor exacto es: %.9f\n',ValorExacto);
    fprintf('\nEl Error absoluto es: %e\n',errorAbs);
end