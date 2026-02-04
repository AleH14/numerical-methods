disp('-----------METODO DE LA POSICION FALSA------------');
syms x
fsyms = input('Ingrese la funcion f(x): ');
f = matlabFunction(fsyms,'Vars',x);
x0 = input('Ingrese el valor de x0: ');
x1 = input('Ingrese el valor de x1: ');
tol = 10^-input('Ingrese el valor de la tolerancia 10^-');

if f(x0)*f(x1)<0
    cont = 1;
    x2= x0- (f(x0)*(x1-x0))/(f(x1) - f(x0));
    error = abs(x2 - x1);
    fprintf('n\t|x0\t\t\t\t\t|x1\t\t\t\t\t|x2\t\t\t\t\t|error\n');
    fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,double(x0),double(x1),double(x2),double(error));
    
    while error > tol && cont <100
        cont = cont + 1;
        if f(x0)*f(x2)<0
            x1= x2;
        else
            x0= x2;
        end
        x2_anterior= x2;
        x2= x0- (f(x0)*(x1-x0))/(f(x1) - f(x0));
        error = abs(x2 - x2_anterior);
       fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,double(x0),double(x1),double(x2),double(error));
    end
    fprintf('\nEl valor aproximado de x es: %.15f\n',double(x2));
    
else
    fprintf('\nEl intervalo proporcionado no contiene una raiz\n');
end
