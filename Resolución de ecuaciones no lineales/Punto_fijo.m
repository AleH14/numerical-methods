disp('------------METODO DEL PUNTO FIJO---------------');
syms x
gsyms = input('Ingrese la funcion g(x): ');
g = matlabFunction(gsyms,'Vars',x);
x0= input('Ingrese la aproximacion inicial x0: ');
tol = 10^-input('Ingrese la tolerancia 10^-');

cont = 1;
x1=g(x0);
error = abs(x1- x0);
fprintf('n\t|x0\t\t\t\t\t|x1\t\t\t\t\t|error\t\t\n');
fprintf('%d\t|%.15f\t|%.15f\t|%o\n',cont,double(x0),double(x1),double(error));

while error > tol && cont <100
    cont =cont + 1;
    x0 = x1;
    x1=g(x0);
    error = abs(x1- x0);
    fprintf('%d\t|%.15f\t|%.15f\t|%o\n',cont,double(x0),double(x1),double(error));
    
end

fprintf('\nEl valor aproximado de x es: %.15f\n',double(x1));


