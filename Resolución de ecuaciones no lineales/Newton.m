disp('------------NEWTON-RAPSHON-------------')
syms x
fsyms= input('Ingrese la funcion f(x): ');
f = matlabFunction(fsyms,'Vars',x);
x0= input('Ingrese el valor aproximacion x0: ');
tol= 10^-input('Ingrese la tolerancia 10^-');

cont = 1;
dfsyms= diff(fsyms);
df = matlabFunction(dfsyms,'Vars',x);

x1 = x0 - f(x0)/df(x0);
error = abs(x1 - x0);

fprintf('n\t| x0\t\t\t\t\t| x1\t\t\t\t\t| error\n');
fprintf('%d\t|%.15f\t\t|%.15f\t\t|%e\n',cont,double(x0),double(x1),double(error));

while error > tol && cont<100
    cont = cont +1;
    x0=x1;
    x1 = x0 - f(x0)/df(x0);
    error = abs(x1 - x0);
    fprintf('%d\t|%.15f\t\t|%.15f\t\t|%e\n',cont,double(x0),double(x1),double(error));
end

fprintf('\nEl valor aproximado de x es: %.15f\n',double(x1));

