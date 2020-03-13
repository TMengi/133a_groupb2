clear;
clc;
close all;

% load data from CEA
alldata = readtable('proptab.csv');

% select combustion pressures
P_cc = 9720; % [kPa]
P_pb = 1.5*P_cc;

% select data subsets
preburner_proptab = alldata(alldata.P == P_pb, :);
mainchamber_proptab = alldata(alldata.P == P_cc, :);

% add OF ratio column
OFR_tab = array2table((.1:.1:2)', 'VariableNames', {'OFR'});
preburner_proptab = [OFR_tab, preburner_proptab];
mainchamber_proptab = [OFR_tab, mainchamber_proptab];

% save as tables
save('preburner_proptab.mat', 'preburner_proptab');
save('mainchamber_proptab.mat', 'mainchamber_proptab');
