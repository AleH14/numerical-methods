disp('------------METODO DE STEFFENSEN---------------');
syms x
gsyms = input('Ingrese la funcion g(x): ');
g = matlabFunction(gsyms,'Vars',x);
x0 = input('Ingrese la aproximacion inicial x0: ');
tol = 10^-input('Ingrese la tolerancia 10^-');

cont = 1;
x1= g(x0);
x2= g(x1);
x3= x0- (x1-x0)^2/( x2-2*x1+x0);
error= abs(x3- x0);
fprintf('n\t|x0\t\t\t\t\t|x1\t\t\t\t\t|x2\t\t\t\t\t|x3\t\t\t\t\t|error\n');
fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,double(x0),double(x1),double(x2),double(x3),double(error));
while error > tol && cont < 100
    cont = cont +1;
    x0 = x3;
    x1= g(x0);
    x2= g(x1);
    x3= x0- (x1-x0)^2/( x2-2*x1+x0);
    error= abs(x3- x0);
    fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,x0,double(x1),double(x2),double(x3),double(error));
end
fprintf('\nEl valor aproximado de x es: %.15f\n',double(x3));