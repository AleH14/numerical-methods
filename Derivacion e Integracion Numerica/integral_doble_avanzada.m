function [valorAproximado, valorExacto, error, errorRelativo] = integral_doble_avanzada( ...
    fxy, ax, bx, cy, dy, nx, ny, metodoX, metodoY)

disp('----------------INTEGRAL DOBLE-----------------');
syms x y

% Asegurar simbólicos
ax = sym(ax); bx = sym(bx);
cy = sym(cy); dy = sym(dy);

% ================= INTEGRAL INTERNA =================
hy = (dy - cy)/ny;
k = 0:ny;
Ysym = cy + k*hy;

Fysym = subs(fxy, y, Ysym);

if strcmpi(metodoY,'trapecio')
    Ky_num = [1 2*ones(1,ny-1) 1];
    Ky = sym(Ky_num);
    gx = hy/2 * sum(Ky .* Fysym);
else
    if mod(ny,2)~=0
        error('ny debe ser par para Simpson.');
    end
    Ky_num = [1 2*ones(1,ny-1) 1];
    Ky_num(2:2:end-1) = 4;
    Ky = sym(Ky_num);
    gx = hy/3 * sum(Ky .* Fysym);
end

 %===== TABLA INTERNA =====
fprintf('\n===== TABLA INTEGRAL INTERNA (en y) =====\n\n');
fprintf('%-3s | %-30s | %-60s | %-3s | %-30s\n', ...
    'i','Yi','f(x,y)','K','K*f');
fprintf(repmat('-',1,150)); fprintf('\n');

Ystr  = arrayfun(@char, Ysym,  'UniformOutput', false);
Fystr = arrayfun(@char, Fysym, 'UniformOutput', false);
Kstr  = arrayfun(@char, Ky,    'UniformOutput', false);

for i = 1:ny+1
    prodStr = char(Ky(i)*Fysym(i));
    fprintf('%-3d | %-30s | %-60s | %-3s | %-30s\n', ...
        i-1, Ystr{i}, Fystr{i}, Kstr{i}, prodStr);
end

fprintf('\nExpresion simbolica de g(x):\n');
disp(char(simplify(gx)));

 %================= INTEGRAL EXTERNA =================
hx = (bx - ax)/nx;
m = 0:nx;
Xsym = ax + m*hx;

gx_func = matlabFunction(gx,'Vars',x);

Xnum = double(Xsym);
Gx_num = gx_func(Xnum);

if strcmpi(metodoX,'trapecio')
    Kx_num = [1 2*ones(1,nx-1) 1];
    valorAproximado = double(hx/2 * sum(Kx_num .* Gx_num));
else
    if mod(nx,2)~=0
        error('nx debe ser par para Simpson.');
    end
    Kx_num = [1 2*ones(1,nx-1) 1];
    Kx_num(2:2:end-1) = 4;
    valorAproximado = double(hx/3 * sum(Kx_num .* Gx_num));
end

 %===== TABLA EXTERNA =====
fprintf('\n===== TABLA INTEGRAL EXTERNA (en x) =====\n\n');
fprintf('%-3s | %-20s | %-25s | %-3s | %-20s\n', ...
    'i','Xi','g(x)','K','K*g');
fprintf(repmat('-',1,85)); fprintf('\n');

Xstr = arrayfun(@char, Xsym, 'UniformOutput', false);

for i = 1:nx+1
    fprintf('%-3d | %-20s | %-25.15f | %-3d | %-20.15f\n', ...
        i-1, Xstr{i}, Gx_num(i), Kx_num(i), Kx_num(i)*Gx_num(i));
end

%================= VALOR EXACTO =================
try
    valorExacto = double(int(int(fxy, y, cy, dy), x, ax, bx));
catch
    valorExacto = NaN;
    warning('No se pudo obtener el valor exacto simbólico.');
end

error = abs(valorExacto - valorAproximado);

if ~isnan(valorExacto) && valorExacto ~= 0
    errorRelativo = error/abs(valorExacto)*100;
else
    errorRelativo = NaN;
end

 %================= RESULTADOS =================
fprintf('\n================ RESULTADOS ================\n');
fprintf('Valor aproximado: %.15f\n', valorAproximado);

if ~isnan(valorExacto)
    fprintf('Valor exacto:     %.15f\n', valorExacto);
else
    fprintf('Valor exacto:     (no disponible)\n');
end

fprintf('Error absoluto:   %e\n', error);

if ~isnan(errorRelativo)
    fprintf('Error relativo:   %.9f%%\n\n', errorRelativo);
else
    fprintf('Error relativo:   (no disponible)\n\n');
end

end