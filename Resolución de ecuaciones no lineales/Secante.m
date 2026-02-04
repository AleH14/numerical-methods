disp('-----------METODO DE LA SECANTE-------------');
syms x
fsyms= input('Ingrese la funcion f(x): ');
f = matlabFunction(fsyms,'Vars',x);
x0 = input('Ingrese el valor de x0: ');
x1 = input('Ingrese el valor de x1: ');
tol = 10^-input('Ingrese la tolerancia 10^-');

cont = 1;
x2= x0 - (f(x0)*(x1-x0))/(f(x1) - f(x0));
error  = abs(x2-x1);
fprintf('n\t|x0\t\t\t\t\t|x1\t\t\t\t\t|x2\t\t\t\t\t|error\n');
fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,double(x0),double(x1),double(x2),double(error));

while error > tol && cont<100
    cont = cont +1;
    x0 = x1;
    x1= x2;
    x2= x0 - (f(x0)*(x1-x0))/(f(x1) - f(x0));
    error  = abs(x2-x1);
    fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,double(x0),double(x1),double(x2),double(error));
end
fprintf('\nEl valor aproximado de x es: %.15f\n',double(x2));
