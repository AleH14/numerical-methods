function comprobar_derivadas_taylor(f, Derivadas_usuario, nt)
    fprintf('\n------------------ VERIFICACION DE DERIVADAS ------------------\n');
    
    % Obtener derivadas correctas automáticamente
    D_correctas = mate.derivadas_edo(f, nt);
    
    todo_bien = true;
    
    for i = 1:nt
        if simplify(Derivadas_usuario(i) - D_correctas{i}) ~= 0
            fprintf(' Derivada #%d incorrecta\n', i);
            fprintf('   Ingresada: ');
            disp(Derivadas_usuario(i));
            fprintf('   Correcta: ');
            disp(D_correctas{i});
            todo_bien = false;
        else
            fprintf(' Derivada #%d correcta\n', i);
        end
    end
    
    if todo_bien
        fprintf('\n Todas las derivadas son correctas\n');
    else
        fprintf('\nHay derivadas incorrectas\n');
    end
end