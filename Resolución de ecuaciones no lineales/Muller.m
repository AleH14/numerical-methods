disp('--------------METODO DE MULLER--------------')
syms x
fsyms = input('Ingrese la funcion f(x): ');
f = matlabFunction(fsyms, 'Vars', x);
x0 = input('Ingrese el valor de x0: ');
x1 = input('Ingrese el valor de x1: ');
x2 = input('Ingrese el valor de x2: ');
tol = 10^-input('Ingrese el valor de la tolerancia 10^-');

cont = 1;
a = ((f(x0)-f(x2))*(x1- x2) - (f(x1)-f(x2))*(x0 - x2))/((x0-x1)*(x0-x2)*(x1-x2));
b = ((f(x1)-f(x2))*(x0- x2)^2 - (f(x0)-f(x2))*(x1 - x2)^2)/((x0-x1)*(x0-x2)*(x1-x2));
c= f(x2);
if b<0
    x3= x2 - (2*c)/(b-sqrt(b^2-4*a*c));
else
    x3= x2 - (2*c)/(b+sqrt(b^2-4*a*c));
end
error = abs(x3 - x2);
fprintf('n\t|x0\t\t\t\t\t|x1\t\t\t\t\t|x2\t\t\t\t\t|x3\t\t\t\t\t|error\n');
fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,double(x0),double(x1),double(x2),double(x3),double(error));

while error > tol && cont <100
    cont = cont +1;
    x0 = x1;
    x1 = x2;
    x2 = x3;
    a = ((f(x0)-f(x2))*(x1- x2) - (f(x1)-f(x2))*(x0 - x2))/((x0-x1)*(x0-x2)*(x1-x2));
    b = ((f(x1)-f(x2))*(x0- x2)^2 - (f(x0)-f(x2))*(x1 - x2)^2)/((x0-x1)*(x0-x2)*(x1-x2));
    c= f(x2);
    if b<0
        x3= x2 - (2*c)/(b-sqrt(b^2-4*a*c));
    else
        x3= x2 - (2*c)/(b+sqrt(b^2-4*a*c));
    end
    error = abs(x3 - x2);
    fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,double(x0),double(x1),double(x2),double(x3),double(error));
end
fprintf('\nEl valor aproximado de x es:%.15f\n',double(x3));
