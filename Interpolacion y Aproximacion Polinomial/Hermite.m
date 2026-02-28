disp('-------------------METODO DE HERMITE-------------------')
syms x
format long
aproximar = input('Ingrese el valor a aproximar: ');
X = input('Ingrese nodos [x0 x1 x2 ...xn]: ');
opcion = input('¿Posee la funcion f(x)? [s/n]: ','s');
n = length(X);
m = n*2;

if opcion =='s'
    f = input('Ingrese la funcion f(x): ');
    Y = subs(f,X);
    DY = double(subs(diff(f), X));
elseif opcion == 'n'
    Y = input('Ingrese las imagenes [f(x0) f(x1) f(x2) ...f(xn)]: ');
    DY = input('Ingrese las imagenes [df(x0) df(x1) df(x2) ...df(xn)]: ');
else
    error('Opcion invalida');
end

Z=zeros(1,m);
Y2 = zeros(1,m);

for i = 1:n
    Z(2*i-1:2*i)  = X(i);
    Y2(2*i-1:2*i) = Y(i);
end

F = zeros(m);
F(:,1) = Y2(:);

for i =2:m
    if mod(i,2)==0
        F(i,2) = DY(i/2);
    else
        F(i,2) = ( F(i,1) - F(i-1,1) )/( Z(i) - Z(i-1));
    end
end

for j = 3 :m
    for i = j :m
        F( i, j) = ( F(i,j-1) - F(i-1,j-1) )/( Z(i) - Z(i-j+1));
    end
end

Polinomio = F(1,1);
term =1;

for k =2:m
    term = term*(x - Z(k-1));
    Polinomio = Polinomio + F(k,k)*term;
end

fprintf('\nMatriz de Hermite: \n');
disp(F);

fprintf('\nPolinomio de Hermite: \n');
pretty(vpa(Polinomio,9));

valorAproximado = subs(Polinomio,aproximar);
fprintf('\nEl valor aproximado es: %.9f\n',double(valorAproximado));

if opcion == 's'
    valorExacto = subs(f,aproximar);
    fprintf('\nEl valor exacto es: %.9f\n',double(valorExacto));
    errorAbs = abs(valorExacto - valorAproximado);
    fprintf('\nEl valor del error absoluto es: %e\n',double(errorAbs));
    
end