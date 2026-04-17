
% fprintf('i\t|Xi\t\t\t\t\t|f(x)\t\t\t\t|K\t\t\t\t|Kf(Xi)\t\t\t\t\t\n');
% fprintf('%d\t|%.15f\t|%.15f\t|%d\t\t|%.15f\t\t\t\n',double(cont),double(Y(1)),double(Fy(1)),double(1),double(Fy(1)));
% for i =2:n+1
%    fprintf('%d\t|%.15f\t|%.15f\t|%d\t\t|%.15f\t\t\t\n',double(i-1),double(Y(i)),double(Fy(i)),double(K(i)),double(K(i)*Fy(i))); 
% end

%fprintf('El valor Aproximado es: %.15f\n',double(valorAproximado));fprintf('El valor Exacto es: %.15f\n',double(valorExacto)); fprintf('El Error es: %e\n',double(error)); fprintf('El error relativo es: %.9f%%\n',double(errorRelativo));

%         %============= NEWTON COTES========================
%     fprintf('%-3s | %-20s | %-20s | %-10s | %-20s\n', ...
%         'i','Xi','f(x)','Wi','Wi*f(Xi)');
%     fprintf(repmat('-',1,85)); fprintf('\n');
%     
%     for i = 1:n+1
%         fprintf('%-3d | %-20.15f | %-20.15f | %-10.6f | %-20.15f\n', ...
%             i-1, double(Y(i)), double(Fy(i)), double(W(i)), double(W(i)*Fy(i)));
%     end

        %============= COMPUESTO========================
fprintf('\n===== Tabla =====\n');
    fprintf('\n');
    fprintf('%-3s | %-20s | %-25s | %-3s | %-20s\n', ...
        'i','Yi','f(y)','K','Kf(Yi)');
    fprintf(repmat('-',1,85)); fprintf('\n');
    
    for i = 1:n+1
        fprintf('%-3d | %-20.15f | %-25.15f | %-3d | %-20.15f\n', ...
            i-1, double(Y(i)), double(Fy(i)), K(i), double(K(i)*Fy(i)));
    end