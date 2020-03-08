%% Adiabatic Flame Temperature

%% Adiabatic flame temperature for kerosene

function [T_flame] = flametemp(T3)
R = 287;

j=1;
for phi=0.5:0.1:1
    phi_store(j) = phi ;
   
    T3(1) = 500 ; %[K] Initial flame temperature guess
    del_T = 10 ;
    T_ad(1) = 1000 ; %[K] Initial Adiabatic flame temperature setting
    i = 1 ; %[] counter
    T_inf = 298 ;
   
    while T3(i) < T_ad(i)
       
        del_kerosene = 46200 ; %kJ/kg Heat of combustion for kerosene: Combustion Science and Engineering pg 990
        n_kerosene       = 0         ;
        % number of mols of reactants
       
        %phi = 1
        n_CO2       = 24*44         ; %[kg]
        n_H2O       = 26*18         ; %[kg]
        n_O2        = 0         ;
       
        n_PMMA      = 0         ;
       
        %Specific heats
        a1 = 0.3644E2;
    a2 = 0.5614801E-1;
    a3 = -0.16091551E-4;
    a4 = 0.2147849E-8;
    a5 = -0.1013118E-12;
    a6 = -0.63890109E5;
    
        c_p_kerosene = R*(a1 + a2*T3(i) + a3*T3(i)^2 + a4*T3(i)^3 + a5*T3(i)^4);
       
        c_p_CO2     = -6.40953e-22*T3(i)^6 +1.35711e-17*T3(i)^5 -1.14921e-13*T3(i)^4 +5.00001e-10*T3(i)^3 -1.19628e-6*T3(i)^2 +1.56371e-3*T3(i) +4.71107e-1 ; %[kJ/(kg K)] 175K-6000K Engineering Toolbox
       
        c_p_H2O     = 1.24400e-21*T3(i)^6   -2.52232e-17*T3(i)^5 +1.98003e-13*T3(i)^4 -7.41265e-10*T3(i)^3 +1.23513e-6*T3(i)^2 -2.26210e-4*T3(i) +1.84352e0 ; %[KJ/(kg K)] 175K-6000K Engineering Toolbox
       
        c_p_O2      = 2e-22*T3(i)^6  -3e-18*T3(i)^5 +2e-14*T3(i)^4 -2e-11*T3(i)^3 -9e-8*T3(i)^2 +0.0003*T3(i) +0.83   ; %[KJ/(kg K)] 175K-6000K Engineering Toolbox
        c_p_CH4     = 1e-20*T3(i)^6  -2e-16*T3(i)^5 +1e-12*T3(i)^4 -4e-09*T3(i)^3  +4e-6*T3(i)^2 +0.0009*T3(i) +1.7695 ; %[KJ/(kg K)] Combustion Science and Engineering pg 1012-1013
        c_p_PMMA = 0 ;
       
        % T_ad(i+1) = T_inf + del_Hc/(n_CO2*c_p_CO2 +n_H2O*c_p_H2O +n_N2*c_p_N2 +n_O2*c_p_O2 +n_CH4*c_p_CH4 + n_PMMA*c_p_PMMA) ;
        T_ad(i+1) = T_inf + (del_kerosene*16)/(n_CO2*c_p_CO2 +n_H2O*c_p_H2O) ;
       
        T3(i+1) = T3(i) + del_T ;
        i=i+1 ;
       
        if i > 10000
            break
        end
       
    end
   
    format short
    T_ad_soln(j) = T_ad(end-1) ;
   
    T_ad_stoic_turns = 2222 ; %[K] adiabatic flame temperature of stoiciometric kerosene from Turns
   
    j=j+1 ;
end