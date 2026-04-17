
disp('-------------------METODO DE NEAREST -----------------------') 
syms x

aproximar = input('Ingrese el valor a aproximar: ');
X = input('Ingrese los nodos [x0 x1 x2 ... xn]: ');
opcion = input('?Posee la funci?n f(x)? [s/n]:','s');
n = length(X);

if opcion == 's'
    f = input('Ingrese la funcion f(x): ');
    Y = subs(f,X);
elseif opcion == 'n'
    Y = input('Ingrese las imagenes [f(x0) f(x1) f(x2) ... f(xn)]: ');
else
    error('Ingrese una opcion valida');
end


[~, idx] = min(abs(X - aproximar));
ValorAproximado = double(Y(idx));


fprintf('\nEl valor aproximado es: %.9f\n',ValorAproximado);

if opcion == 's'
    ValorExacto = double(subs(f,aproximar));
    errorAbs = abs(ValorExacto - ValorAproximado);
    fprintf('\nEl Valor exacto es: %.9f\n',ValorExacto);
    fprintf('\nEl Error absoluto es: %e\n',errorAbs);
end
