disp('----------METODO DE EULER---------');
syms t y
fsyms = input('Ingrese la funcion f(t,y): ');
I = input('Ingrese el intervalo [a,b]: ');
Y0=input(sprintf('Ingrese la condicion inicial Y(%d)=',double(I(1))));
h = input('Ingrese el valor de h: ');
Fsyms_Exacta = input('Ingrese la solucion exacta F(t): ');

n = round((I(2) -I(1))/h); T = linspace(I(1),I(2),n+1);
Y= zeros(1,n+1);
Error = zeros(1, n+1);
Y(1)=Y0;
F = subs(Fsyms_Exacta,T);
f = matlabFunction(fsyms,'Vars',[t y]);

fprintf('\nT\t\t\t\t|Y(t)\t\t\t|F(t)\t\t\t|Error\n');
fprintf('%.10f\t|%.10f\t|%.10f\t|%.10e\n',double(T(1)),double(Y(1)),double(F(1)),double(Error(1)));

for i=1:n
    Y(i+1) = Y(i) + h*f(T(i),Y(i));
    Error(i+1)  = abs(F(i+1) - Y(i+1));
    fprintf('%.10f\t|%.10f\t|%.10f\t|%.10e\n',double(T(i+1)),double(Y(i+1)),double(F(i+1)),double(Error(i+1)));
end

fprintf('\nResultados: \n');
fprintf('Aproximado : Y(%.10f)=%.10f\n',double(T(end)),double(Y(end)));
fprintf('Exacto :     F(%.10f)=%.10f\n',double(T(end)),double(F(end)));
fprintf('Error :      %.10e\n',double(Error(end)));