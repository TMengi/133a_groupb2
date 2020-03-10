%%This function claculates the pump power based on the bernoulli equation
%mdot = mass flow rate of the fluid
%density
%efficiency = efficiency of the pump in decimal
%Pi = initial pressure entering pump
%Pe = final pressure leaving the pump
function [pumpP] = pumpPower(mdot,density,efficiency,Pe,Pi)
    if (efficiency > 1) || (efficiency < 0)
       error('The efficiency should be a decimal value from 0 to 1');
    end
    pumpP = (mdot*(Pe-Pi))/(density*efficiency);
end
