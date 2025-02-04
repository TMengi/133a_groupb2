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
eff = linspace(.7, .99, n)';
%m_dot = linspace(6, 12, n)';
% m_dotfuel = 10*linspace(1, 20, n)'; %kg/s
% m_dotlox = 10.1*linspace(1, 20, n)';
m_dotfuel = 1;
m_dotLOx = 1.01;

%%%%%%%%%%%%%%%% PRE-BURNER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T3 = [];
i = 1;

% for i = 1:n
% T3(i) = flametemp(m_dotlox(i), m_dotfuel(i));
% end

T3 = flametemp(m_dotLOx, m_dotfuel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TURBINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inlet and Outlet conditions
T3 = T3(1);
T4 = 1100; % enthalpy assuming turbine exhaust is at 1 atm
Powerturb = 7456.999;    %kW
m_dotfuelmax = 1122; %kg/s
m_dotLOxmax = 1234;  %kg/s
h4 = enthalpy(T4); % enthalpy out of turbine
[h3] = enthalpy(T3); % enthalpy into turbine
i = 1;
j = 1;

m_dot_tot = [];
m_dotLOx = [];
m_dotfuel = [];

    
for j = 1:n
        
        m_dot_tot(j) = Powerturb/((h3-h4)*eff(j))*(310/.8395);
        
        m_dotLOx(j) = (1.01/2.01)* m_dot_tot(j);
       
        m_dotfuel(j) = m_dotLOx(j)/ 1.01;
end
   
 %% 
gamma = 1.2;
P4 = 9270; %kPa
P3 = 101.3;

PR = [100; 10; 4.642; 3.162];
TR = 2.7;
p = (gamma-1)/gamma;
stages = [1; 2; 3; 4];
for i = 1:4
    np(i) = log(TR)/((log(PR(i)))^(p));
    nt(i) = (1 - (PR(i))^(np(i)*p))/(1-PR(i)^p);
end
 
%%

% %%%%%%%%%%%%%%%% CC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Inlet and Outlet conditions
% T3 = T3(1);
% %T4 = linspace(600, 800, n)';
% %T4 = 
% PowerCC = 2.8E6;    %kW
% m_dotfuelmax = 1122; %kg/s
% m_dotLOxmax = 1234;  %kg/s
% i = 1;
% j = 1;
% 
% h5 = []; %enthalpy out of CC
% 
% m_dot_tot = [];
% 
%     
%     for j = 1:n
%         
%         [h3] = enthalpy(T3); %inlet enthalpy
%         h5(j) = h4(j) - PowerCC./((m_dotfuelmax + m_dotLOxmax)-(m_dotfuel(j)+ m_dotlox(j)));
%         %exit enthalpy
%         m_dot_tot(j) = m_dotfuel(j)+ m_dotlox(j);
%         
%     end
%     
% 
% for i = 1:n
%     yy(:, i) = smooth(h4(:, i));
% end
% 
% for i = 1:n
%     zz(:, i) = smooth(yy(:, i));
% end
% 
% for i = 1:n
%     ww(:, i) = smooth(zz(:, i));
% end
% 
% 
% 
% figure
% plot(m_dot_tot, h5, 'LineWidth', 3)
% %meshc(Work)
% set(gca, 'FontSize', 14, 'FontWeight', 'bold')
% %xlabel('\Delta T[K]')
% %ylabel('Mass Flow Rate [kg/s]')    
% xlabel('Gas-Generator Mass Flow Rate [kg/s]')
% ylabel('Combustion Chamber Gas Enthalpy [kJ/kg]')
% box on
% 
% % figure
% % plot(m_dot_tot, h4, m_dot_tot, h5)
% % legend('Turbine Outlet Enthalpy', 'CC Outlet Enthalpy')
 

figure
plot(stages, [310; 259.1; 237.5; 222.6], 'LineWidth', 3)
%meshc(Work)
set(gca, 'FontSize', 14, 'FontWeight', 'bold')
%xlabel('\Delta T[K]')
%ylabel('Mass Flow Rate [kg/s]')    
xlabel('Numer of Turbine Stages')
ylabel('Mass Flow Rate Required through the Turbine')
grid on
grid minor
box on


figure
plot(m_dot_tot*(h3-h4), eff, 'LineWidth', 3)
set(gca, 'FontSize', 14, 'FontWeight', 'bold')
%xlabel('\Delta T[K]')
%ylabel('Mass Flow Rate [kg/s]')    
xlabel('Turbine Efficiency')
ylabel('Turbine Power')
box on

figure
plot(stages, nt, 'LineWidth', 3)
set(gca, 'FontSize', 14, 'FontWeight', 'bold')
%xlabel('\Delta T[K]')
%ylabel('Mass Flow Rate [kg/s]')    
xlabel('Numer of Turbine Stages')
ylabel('Isentropic Turbine Efficiency')
grid on
grid minor
box on

figure
plot(stages, nt, 'LineWidth', 3)
set(gca, 'FontSize', 14, 'FontWeight', 'bold')
%xlabel('\Delta T[K]')
%ylabel('Mass Flow Rate [kg/s]')    
xlabel('Numer of Turbine Stages')
ylabel('Isentropic Turbine Efficiency')
grid on
grid minor
box on
