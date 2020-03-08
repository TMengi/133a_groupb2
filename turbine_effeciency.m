close all
clear all
clc

% %% Assumptions
% % State of matter entering turbine and exit pressure are fixed.
% % Heat transfer between turbine and its surroundings is ignored.
% % Kinetic and Potential energy effects negligible.
% % Steady State.
% % Each pump recieves 0.5 of Turbine Work



%%%%%%%%%%%%%%%% TURBINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inlet and Outlet conditions
P1 = 3564.59;
P2 = 268;

eff = linspace(.4, .99, 100)';
%m_dot = linspace(6, 12, 100)';
m_dotfuel = 1012; %kg/s
m_dotlox = linspace(100, 1000, 100)';
T1 = linspace(800, 1533, 100)';
T2 = linspace(600, 1403, 100)';
Work = [];
i = 1;
j = 1;

for i = 1:length(eff)
    
    for j = 1:length(eff)
                
        [h1, h2] = enthalpy(T1(j), T2(j));
        Work(j, i) = (m_dotfuel+m_dotlox(i)).*(h1 - h2);      
        
        j = j+1;
    end
    
    i = i+1;
    
end

for i = 1:100
    yy(:, i) = smooth(Work(:, i));
end

for i = 1:100
    zz(:, i) = smooth(yy(:, i));
end

for i = 1:100
    ww(:, i) = smooth(zz(:, i));
end

for i = 1:100
    aa(:, i) = smooth(ww(:, i));
end

for i = 1:100
    bb(:, i) = smooth(aa(:, i));
end

figure
surfc((T1 - T2), m_dotlox, aa)
%meshc(Work)
 set(gca, 'FontSize', 14, 'FontWeight', 'bold')
 %xlabel('\Delta T[K]')
 %ylabel('Mass Flow Rate [kg/s]')
 zlabel('Turbine Work [kW]')
 xlabel('\Delta T [K]')
 ylabel('LOx FlowRate [kg/s]')
 box on
 shading interp
 s.EdgeColor = 'none';
 colorbar
 
 
 
 
 