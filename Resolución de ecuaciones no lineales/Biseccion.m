disp('-----------METODO DE BISECCION--------------');
syms x
fsyms = input('Ingrese la funcion f(x): ');
f = matlabFunction(fsyms,'Vars',x);
a = input('Ingrese el valor de a: ');
b = input('Ingrese el valor de b: ');
tol = 10^-input('Ingrese la tolerancia 10^-');

if f(a)*f(b)<0
    cont = 1;
    c = ( a + b)/2;
    error = abs(f(c));
    fprintf('n\t|a\t\t\t\t\t|b\t\t\t\t\t|c\t\t\t\t\t|error\t\t\n');
    fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,double(a), double(b), double(c), double(error));
    while error>tol && cont <100
        cont= cont +1;
        if f(a)*f(c)<0
            b= c;
        else
            a=c;
        end
        c_anterior = c;
        c = ( a + b)/2;
        error = abs(c-c_anterior);
        fprintf('%d\t|%.15f\t|%.15f\t|%.15f\t|%e\n',cont,double(a), double(b), double(c), double(error));
    end
    fprintf('\nEl valor de aproximado de x es: %.15f\n',double(c));  
else 
    fprintf('\nEl intervalo no contiene a la raiz\n');
end