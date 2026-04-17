disp('----------METODO DE EXTRAPOLACION DE RICHARDSON-----------');
syms x
c = input('Ingrese el valor a aproximar: ');
n = input('Ingrese el orden matriz: ');
h = input('Ingrese el valor de h: ');
f = input('Ingrese la fucion f(x): ');
N = zeros(n);

for i=1:n
    N(i,1) = (subs(f,c + h) - subs(f,c-h))/(2*h);
    h = h/2;
end

for j=2:n
    for i=1:n-j+1
        N(i,j) = ((4^(j-1))*N(i+1,j-1) - N(i,j-1))/(4^(j-1) -1);
    end
end

fprintf('\nLa Matriz de Richardson es: \n');
disp(vpa(N,15));
valorAproximado = N(1,n);
fprintf('\nEl Valor Aproximado es:%.15f \n',double(valorAproximado));

valorExacto = subs(diff(f),c);
fprintf('\nEl Valor Exacto es:%.15f \n',double(valorExacto));
error = abs(double(valorExacto) - valorAproximado);
fprintf('\nEl error es: %e\n',double(error))