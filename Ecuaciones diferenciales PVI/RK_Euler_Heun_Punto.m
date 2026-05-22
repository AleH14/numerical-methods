
% 1. Mostrar menú de opciones
disp('----------------------------------------------------');
disp('   MÉTODOS DE RUNGE-KUTTA DE SEGUNDO ORDEN (RK2)    ');
disp('----------------------------------------------------');
disp('Seleccione el método que desea utilizar:');
disp('1. Método de Euler Mejorado');
disp('2. Método de Heun');
disp('3. Método del Punto Medio');
disp('----------------------------------------------------');

opcion = input('Ingrese el número de la opción (1/2/3): ');

% Validar la opción elegida
if ~ismember(opcion, [1, 2, 3])
    disp('Error: Opción no válida. Ejecute el programa nuevamente.');
    return;
end

% Asignar el nombre del método según la opción
switch opcion
    case 1
        nombre_metodo = 'MÉTODO DE EULER MEJORADO';
    case 2
        nombre_metodo = 'MÉTODO DE HEUN';
    case 3
        nombre_metodo = 'MÉTODO DEL PUNTO MEDIO';
end

fprintf('\n------------------ %s ------------------\n', nombre_metodo);

% 2. Ingreso de datos (se pide una sola vez)
syms t y

fsyms = input('Ingrese la función de la ecuación diferencial (dy/dt=f(t,y)): ');
I = input('Ingrese el intervalo de aproximacion [a ,b]: ');
Y0 = input(sprintf('Ingrese la condicion inicial Y(%d)=', I(1)));
h = input('Ingrese el valor de h: ');
Fsyms_Exacta = input('Ingrese la solución exacta: ');

a = I(1);
b = I(2);

n = round((b-a)/h);
T = linspace(a, b, n+1);

% Convertir a funciones numéricas (MUCHO más rápido)
f = matlabFunction(fsyms, 'Vars', [t y]);
F = matlabFunction(Fsyms_Exacta, 'Vars', t);

Y = zeros(1, n+1);
Error = zeros(1, n+1);

Y(1) = Y0;
F_Exacta = F(T);

% 3. Imprimir encabezado de la tabla
fprintf('\nti\t\t|k1\t\t\t\t\t|k2\t\t\t\t\t|Y(ti)\t\t\t\t|F(ti)\t\t\t\t|Error');
fprintf('\n%.4f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%e' ,T(1), 0, 0, double(Y(1)), double(F_Exacta(1)), double(0));

% 4. Iteraciones
for i = 1:n
    % k1 es igual para los tres métodos
    k1 = f(T(i), Y(i));
    
    % Variación de k2 y Y(i+1) según el método elegido
    switch opcion
        case 1 % Euler Mejorado
            k2 = f(T(i) + h, Y(i) + h*k1);
            Y(i+1) = Y(i) + (h/2)*(k1 + k2);
            
        case 2 % Heun
            k2 = f(T(i) + (2/3)*h, Y(i) + (2/3)*h*k1);
            Y(i+1) = Y(i) + (h/4)*(k1 + 3*k2);
            
        case 3 % Punto Medio
            k2 = f(T(i) + h/2, Y(i) + (h/2)*k1);
            Y(i+1) = Y(i) + h*k2;
    end
    
    % Cálculo del error absoluto
    Error(i+1) = abs(F_Exacta(i+1) - Y(i+1));
    
    % Imprimir fila de la iteración
    fprintf('\n%.4f\t|%.15f\t|%.15f\t|%.15f\t|%.15f\t|%e' ,T(i+1), double(k1), double(k2), double(Y(i+1)), double(F_Exacta(i+1)), Error(i+1));
end

% 5. Resultados Finales
fprintf('\n\nResultado final (%s):\n', nombre_metodo);
fprintf('Aproximado: y(%.4f) = %.15f\n', T(end), Y(end));
fprintf('Exacto:     y(%.4f) = %.15f\n', T(end), F_Exacta(end));
fprintf('Error:      %e\n', Error(end));

% Llamada a tu función de validación (debes asegurarte de tener verificar_solucion.m en tu ruta)
mate.verificar_solucion(fsyms, Fsyms_Exacta, Y0, a)