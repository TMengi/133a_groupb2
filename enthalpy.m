%% Calculate enthalpy

% This function uses experimentally derived coefficients from a NASA paper
% (see references) to calculate the enthalpy of kerosene.

function [h1, h2] = enthalpy(T1, T2)
R = .287; %KJ/KJ K

if  T1 > 1000
    a1 = 0.3644E2;
    a2 = 0.5614801E-1;
    a3 = -0.16091551E-4;
    a4 = 0.2147849E-8;
    a5 = -0.1013118E-12;
    a6 = -0.63890109E5;
    
    h1 = R*T1*(a1 + a2/2*T1 + a3/3*T1^2 + a4/4*T1^3 + a5/5*T1^4 + a6/T1);
    
elseif T1 <= 1000
    a1 = 0.39508691E1;
    a2 = 0.1020798;
    a3 = 0.13124466E-4;
    a4 = -0.76649284E-7;
    a5 = 0.34503763E-10;
    a6 = -0.52093574E5;
    
    h1 = R*T1*(a1 + a2/2*T1 + a3/3*T1^2 + a4/4*T1^3 + a5/5*T1^4 + a6/T1);
end

if  T2 > 1000
    a1 = 0.3644E2;
    a2 = 0.5614801E-1;
    a3 = -0.16091551E-4;
    a4 = 0.2147849E-8;
    a5 = -0.1013118E-12;
    a6 = -0.63890109E5;
    
    h2 = R*T2*(a1 + a2/2*T2 + a3/3*T2^2 + a4/4*T2^3 + a5/5*T2^4 + a6/T2);
    
elseif T2 <= 1000
    a1 = 0.39508691E1;
    a2 = 0.1020798;
    a3 = 0.13124466E-4;
    a4 = -0.76649284E-7;
    a5 = 0.34503763E-10;
    a6 = -0.52093574E5;
    
    h2 = R*T2*(a1 + a2/2*T2 + a3/3*T2^2 + a4/4*T2^3 + a5/5*T2^4 + a6/T2);
end
end 


