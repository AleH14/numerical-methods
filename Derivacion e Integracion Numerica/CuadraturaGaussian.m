disp('------------METODO DE CUADRATURA GAUSSINA--------------');
syms x
ft = input('Ingrese la funcion f(t): ');
p = input('Ingrese el polinomio de legendre: ');

dp=diff(p);
X=real(double(solve(p)));
n=length(X);
W=zeros(n,1);
Ft=subs(ft,t,X);

for i=1:n
    I=int(p/(x - X(i)),-1,1,'PrincipalValue',true);
    W(i) = ((subs(dp,X(i)))^(-1))*I;
end

valorAproximada =sum(W .* Ft);
fprintf('\n\nEl valor Aproximado es: %.15f\n\n',double(valorAproximada));

    fprintf('%-3s | %-20s | %-20s | %-20s\n', ...
        'i','Xi','Wi','Wi*f(ti)');
    fprintf(repmat('-',1,75)); fprintf('\n');
    
    for i = 1:n
        fprintf('%-3d | %-20.15f | %-20.15f | %-20.15f\n', ...
            i-1, double(X(i)), double(W(i)), double(W(i)*Ft(i)));
    end


