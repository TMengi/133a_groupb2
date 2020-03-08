%fuelPump
%This function calculates the enthalpy at the exit of the fueld pump

%mf = mass flow rate of fuel
%h1 = enthalpy of fuel before entering pump
%h2s = enthalpy of fuel exiting the pump assuming s2s = s1
%workPump = the work of the pump
%pumpEff = the efficiency of the pump as a decimal value. 
function [h2] = fuelPump(mf,h1,workPump,pumpEff)

    if (pumpEff > 1)
        error('the pumpEff value is a decimal value less than or equal to one')
    end
    
    h2s = (workPump/mf) + h1;
    h2 = ((h2s-h1)/pumpEff) + h1;
end