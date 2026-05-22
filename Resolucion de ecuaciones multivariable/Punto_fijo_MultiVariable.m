disp('-----------METODO DE PUNTO FIJO MULTIVARIABLE------------');
syms x y z
Gsyms = [
    input('Ingrese la g(x,y,z) correspondiente a x: ');
    input('Ingrese la g(x,y,z) correspondiente a y: ');
    input('Ingrese la g(x,y,z) correspondiente a z: ')
    
    ];

X0= [
    input('Ingrese el x0: ');
    input('Ingrese el y0: ');
    input('Ingrese el z0: ')
    ];

tol = 10^-input('Ingrese el valor de la tolerancia 10^-');
G = matlabFunction(Gsyms,'Vars',{[x; y; z]});
fprintf('\nn\t|x\t\t\t\t|y\t\t\t\t|z\t\t\t\t|Error\n');
fprintf('%d\t|%.10f\t|%.10f\t|%.10f\t|%.10e\n',1,double(X0(1)),double(X0(2)) ,double(X0(3)),double(0)  );

for i=2:100
    X1 = G(X0);
    error=max(abs(X1-X0));
    fprintf('%d\t|%.10f\t|%.10f\t|%.10f\t|%.10e\n',i,double(X1(1)),double(X1(2)) ,double(X1(3)),double(error)  );
    if error<tol 
        break
    end
    X0=X1;

end

fprintf('\nResultados: \n');
fprintf('El valor aproximado de x* es: %.10f \n',double(X1(1)));
fprintf('El valor aproximado de y* es: %.10f \n',double(X1(2)));
fprintf('El valor aproximado de z* es: %.10f \n',double(X1(3)));
fprintf('El valor del error es: %.10e\n',double(error));