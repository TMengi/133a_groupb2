close all
clear all
clc

% %% Assumptions
% % State of matter entering turbine and exit pressure are fixed.
% % Heat transfer between turbine and its surroundings is ignored.
% % Kinetic and Potential energy effects negligible.
% % Steady State.
% % Each pump recieves 0.5 of Turbine Work


%% Conditions
n = 20;
eff = linspace(.4, .99, n)';
%m_dot = linspace(6, 12, n)';
m_dotfuel = 10*linspace(1, 20, n)'; %kg/s
m_dotlox = 10.1*linspace(1, 20, n)';

%%%%%%%%%%%%%%%% PRE-BURNER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T3 = [];
i = 1;

for i = 1:n
T3(i) = flametemp(m_dotlox(i), m_dotfuel(i));
end

T3 = T3';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TURBINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inlet and Outlet conditions
T3 = T3(1);
%T4 = linspace(600, 800, n)';
%T4 = 
Powerturb = 7456.999;    %kW
m_dotfuelmax = 1122; %kg/s
m_dotLOxmax = 1234;  %kg/s
i = 1;
j = 1;

h4 = []; %enthalpy out of turbine

m_dot_tot = [];

    
    for j = 1:n
        
        [h3] = enthalpy(T3); %enthalpy into turbine
        h4(j) = h3 - Powerturb./((m_dotfuel(j)+ m_dotlox(j)));
        
        m_dot_tot(j) = m_dotfuel(j)+ m_dotlox(j);
        
    end
    
%%%%%%%%%%%%%%%% CC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inlet and Outlet conditions
T3 = T3(1);
%T4 = linspace(600, 800, n)';
%T4 = 
PowerCC = 2.8E6;    %kW
m_dotfuelmax = 1122; %kg/s
m_dotLOxmax = 1234;  %kg/s
i = 1;
j = 1;

h5 = []; %enthalpy out of CC

m_dot_tot = [];

    
    for j = 1:n
        
        [h3] = enthalpy(T3); %inlet enthalpy
        h5(j) = h4(j) - PowerCC./((m_dotfuelmax + m_dotLOxmax)-(m_dotfuel(j)+ m_dotlox(j)));
        %exit enthalpy
        m_dot_tot(j) = m_dotfuel(j)+ m_dotlox(j);
        
    end
    

for i = 1:n
    yy(:, i) = smooth(h4(:, i));
end

for i = 1:n
    zz(:, i) = smooth(yy(:, i));
end

for i = 1:n
    ww(:, i) = smooth(zz(:, i));
end



figure
plot(m_dot_tot, h5, 'LineWidth', 3)
%meshc(Work)
set(gca, 'FontSize', 14, 'FontWeight', 'bold')
%xlabel('\Delta T[K]')
%ylabel('Mass Flow Rate [kg/s]')    
xlabel('Gas-Generator Mass Flow Rate [kg/s]')
ylabel('Combustion Chamber Gas Enthalpy [kJ/kg]')
box on

% figure
% plot(m_dot_tot, h4, m_dot_tot, h5)
% legend('Turbine Outlet Enthalpy', 'CC Outlet Enthalpy')
 