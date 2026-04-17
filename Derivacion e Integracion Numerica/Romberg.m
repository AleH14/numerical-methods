disp('----------METODO DE INTEGRACION DE ROMBERG-----------'); 
syms x

a = input('Ingrese el limite inferior: ');
b = input('Ingrese el limite superior: ');
n = input('Ingrese el orden de la matriz: ');
f = input('Ingrese la funcion f(x): ');

if n <= 0
    error('n debe ser mayor que 0');
end

% Convertir a función numérica
f_num = matlabFunction(f);

R = zeros(n);

% -------- Primera columna (Trapecio compuesto) --------
for i = 1:n
    N = 2^(i-1); % número de subintervalos
    h = (b - a)/N;

    suma = 0;
    for k = 1:N-1
        suma = suma + f_num(a + k*h);
    end

    R(i,1) = (h/2)*(f_num(a) + 2*suma + f_num(b));
end

% -------- Extrapolación de Richardson --------
for j = 2:n
    for i = j:n
        R(i,j) = ((4^(j-1))*R(i,j-1) - R(i-1,j-1))/(4^(j-1) - 1);
    end
end

% -------- Resultados --------
disp('Matriz de Romberg:');
disp(vpa(R,10));

valorAproximado = R(n,n);
fprintf('\nValor aproximado: %.15f\n', valorAproximado);

% Valor exacto (si es posible simbólicamente)
valorExacto = double(int(f, a, b));
fprintf('Valor exacto: %.15f\n', valorExacto);

error = abs(valorExacto - valorAproximado);
fprintf('Error: %e\n', error);

errorRelativo = error/valorExacto*100;
fprintf('Error relativo porcentual: %.15f%%\n',double(errorRelativo));