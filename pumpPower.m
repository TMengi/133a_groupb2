
%%This function claculates the pump power based on the equations given on
%%page 287 of Mechanics and Thermdynamics of Propulsion

%mdot = mass flow rate of the fluid
%Ti = the initial temperature at the entrance of the pump
%efficiency = efficiency of the pump in decimal
%Pi = initial pressure entering pump
%Pf = final pressure leaving the pump
%gamma = heat capacity ratio of the fluid
%cp = specific heat at constant pressure
%ctheta1 = tangential velocity of fluid entering rotor
%ctheta2 = tangential velocity of fluid exiting rotor

function [pumpPower] = pumpPower(mdot,Ti,efficiency,Pi,Pf,gamma,cp,ctheta1,ctheta2)
    deltaTo = (Ti/efficiency)*((Pf/Pi)^((gamma-1)/gamma) - 1);
    U = (deltaTo*cp)/(ctheta2-ctheta1);
    pumpPower = U*mdot*(ctheta1-ctheta2);
end
