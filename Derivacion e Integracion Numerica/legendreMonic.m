function P_monic = legendreMonic(n)
    syms x
    
    P = expand(legendreP(n, x));
    
    coef = sym2poly(P);
    coef_leader = coef(1);
    
    % Normalizar y forzar forma bonita
    P_monic = collect(expand(P / coef_leader), x);
end