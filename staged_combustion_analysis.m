% staged_combustion_analysis.m
% 
% given combustion chamber pressure, preburner pressure, and mass flow
% rates, calculate the chamber enthalpy and gamma
% 
% assumptions:
% - steady state
% - changes to KE and PE are negligible
% - fuel and LOX are stored at atmospheric pressure
% - combustion at constant pressure
% - pump and turbine efficiencies are known
% - pumps and turbine are adiabatic
% - fuel flow to main chamber is pure RP-1

clear;
clc;
close all;

% properties
rho_fuel = 860; % [kg/m^3]
rho_lox = 1141; % [kg/m^3]
P_atm = 101.325; % [kPa]

%% pumps

% assumed efficiency
eta_p = .8;

% assumed chamber pressure
P_cc = 9720; % [kPa]
P_pb = 1.5*P_cc;

% assumed mass flow rates
m_fuel = 733; % [kg/s]
m_lox = 1122; % [kg/s]

% specific work for each pump, assuming tank pressures of 1 atm
% Wp/mdot = (Delta P)/rho / eta

% work to pump one kg of fuel from tank pressure to preburner pressure
Wp_fuel_spec = (P_pb - P_atm)/rho_fuel / eta_p; % [kW/kg]

% work to pump one kg of lox from tank pressure to chamber pressure
Wp_lox_spec = (P_cc - P_atm)/rho_lox / eta_p; % [kW/kg]

%% preburner

% load property table from CEA
load('preburner_proptab.mat');

% assumed bleed-off into preburner
m_lox_pb = 233; % [kg/s]

% total mass flow through preburner
m_pb = m_lox_pb + m_fuel;

% OF ratio
OFR_pb = m_lox_pb/m_fuel;

% interpolate properties based on OFR
T_pb_outlet = linterp(preburner_proptab.OFR, preburner_proptab.T, OFR_pb); % [K]
h_pb_outlet = linterp(preburner_proptab.OFR, preburner_proptab.h, OFR_pb); % [kJ/kg]
v_pb_outlet = 1/linterp(preburner_proptab.OFR, preburner_proptab.rho, OFR_pb); % [m^3/kg]
gam_pb_outlet = linterp(preburner_proptab.OFR, preburner_proptab.gamma, OFR_pb); % [kJ/kg]

% print results
fprintf('\n----- PREBURNER -----\n');
fprintf('O/F ratio: %.2f\n', OFR_pb);
fprintf('chamber pressure: %.0f kPa\n', P_pb);
fprintf('chamber tempertaure: %.0f K\n', T_pb_outlet);
fprintf('enthalpy: %.1f kJ/kg\n', h_pb_outlet);
fprintf('specific volume: %4.3e m^3/kg\n', v_pb_outlet);
fprintf('gamma: %.2f\n', gam_pb_outlet);

%% turbine

% preburner feeds turbine
T_turb_inlet = T_pb_outlet;
h_turb_inlet = h_pb_outlet;
v_turb_inlet = v_pb_outlet;

% assumed efficiency
eta_turb = .7;

% total turbine work is the total pump work
Wturb = (Wp_fuel_spec*m_fuel + Wp_lox_spec*m_lox) / eta_turb; % [kW]

% outlet enthalpy from energy balance
h_turb_outlet = h_turb_inlet - Wturb/m_pb;

% outlet temperature from isentropic relation with efficiency term
T_turb_outlet = T_turb_inlet*(P_cc/P_pb)^((gam_pb_outlet - 1)/gam_pb_outlet * eta_turb);

% outlet specific volume from isentropic relation with efficiency term
v_turb_outlet = v_turb_inlet*(P_pb/P_cc)^(-1/gam_pb_outlet * eta_turb);

% print results
fprintf('\n----- TURBINE -----\n');
fprintf('work out: %.1f kW\n', Wturb);
fprintf('outlet temperature: %.0f K\n', T_turb_outlet);
fprintf('enthalpy change: %.1f kJ/kg\n', h_turb_outlet - h_turb_inlet);

%% main chamber

% load property table from CEA
load('mainchamber_proptab.mat');

% remaining LOX flow
m_lox_cc = m_lox - m_lox_pb;

% OF ratio
OFR_cc = m_lox_cc/m_fuel;

% interpolate properties based on OFR
T_cc_outlet = linterp(mainchamber_proptab.OFR, mainchamber_proptab.T, OFR_cc);
h_cc_outlet = linterp(mainchamber_proptab.OFR, mainchamber_proptab.h, OFR_cc);
v_cc_outlet = 1/linterp(mainchamber_proptab.OFR, mainchamber_proptab.rho, OFR_cc);
gam_cc_outlet = linterp(mainchamber_proptab.OFR, mainchamber_proptab.gamma, OFR_cc);

% print results
fprintf('\n----- MAIN CHAMBER -----\n');
fprintf('O/F ratio: %.2f\n', OFR_cc);
fprintf('chamber pressure: %.0f kPa\n', P_cc);
fprintf('chamber temperature: %.0f K\n', T_cc_outlet);
fprintf('outlet enthalpy: %.1f kJ/kg\n', h_cc_outlet);
fprintf('specific volume: %4.3e m^3/kg\n', v_cc_outlet);
fprintf('gamma: %.2f\n', gam_cc_outlet);