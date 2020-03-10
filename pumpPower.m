%%This function calculates the pump power based on the bernoulli equation.
%INPUTS
%mdot = mass flow rate of the working fluid (kg/s)
%density = density of the working fluid (kg/m^3)
%efficiency = efficiency of the pump (decimal value)
%Pi = initial pressure entering pump (Pascal)
%Pe = final pressure leaving the pump (Pascal)

%OUTPUTS
%pumpP = the power required to drive pump (Watts)
function [pumpP] = pumpPower(mdot,density,efficiency,Pe,Pi)
    if (efficiency > 1) || (efficiency < 0)
       error('The efficiency should be a decimal value from 0 to 1');
    end
    pumpP = (mdot*(Pe-Pi))/(density*efficiency);
end
