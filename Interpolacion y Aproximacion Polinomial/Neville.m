disp('-------------------METODO DE NEVILLE-------------------')
syms x
format long
aproximar = input('Ingrese el valor a aproximar: ');
X = input('Ingrese los nodos [x0 x1 x2 ... xn]: ');
opcion = input('¿Posee la funcion f(x)? [s/n]: ','s');
n = length(X);
Q = zeros(n);

if opcion == 's'
    f = input('Ingrese la funcion f(x): ');
    Y = subs(f,X);
elseif opcion == 'n'
    Y = input('Ingrese los imagenes [f(x0) f(x1) f(x2) ... f(xn)]: ');
else
    error('Ingrese una opcion valida');  
end

Q(:,1)= Y(:);

for j=2:n
    for i=j:n
        Q(i,j)= ((aproximar-X(i-j+1))*Q(i,j-1) - (aproximar - X(i))*Q(i-1,j-1))/(X(i) - X(i-j+1));
    end
end

fprintf('\nMatriz de Neville: \n');
disp(Q);
valorAproximado =Q(n,n);
fprintf('\nEl valor aproximado es: %.9f\n',double(valorAproximado));

if opcion == 's'
    valorExacto = double(subs(f,aproximar));
    fprintf('\nEl valor exacto es: %.9f\n',valorExacto);
    error = abs(valorExacto - valorAproximado);
    fprintf('\nEl El error absoluto es: %e\n',error);
    
end