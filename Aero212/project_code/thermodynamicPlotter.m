clc; clear; close all;

%% CLEAN THIS UP!
% Maybe create a class called AnalysisProcedure and create 2 or 4 instances
% of this object. One for air standard and one for cold air standard. Then
% look at how to handle after burner vs. regular data. etc. etc.

%% Initialize Air Standard Variables.

% Load the data for air standard.
air_temperatures = csvread('data/air_temperatures.csv');
air_regularTemperatures = air_temperatures(1:end-1,1);
air_afterburnTemperatures = air_temperatures(:,2);

air_pressures = csvread('data/air_pressures.csv');
air_regularPressures = air_pressures(1:end-1,1);
air_afterburnPressures = air_pressures(:,2);

% Initalize air standard entropy arrays.
air_regularEntropies = zeros(length(air_regularTemperatures), 1);
air_regularEntropies(1) = -3;
air_afterburnEntropies = zeros(length(air_afterburnTemperatures), 1);
air_afterburnEntropies(1) = -3;

% Initalize air standard specific volume arrays.
air_regularSpecificVolumes = zeros(length(air_regularTemperatures), 1);
air_afterburnSpecificVolumes = zeros(length(air_afterburnTemperatures), 1);

%% Initialize Cold Air Standard Variables.

% Load the data for cold air standard.
cold_temperatures = csvread('data/cold_temperatures.csv');
cold_regularTemperatures = cold_temperatures(1:end-1,1);
cold_afterburnTemperatures = cold_temperatures(:,2);

cold_pressures = csvread('data/cold_pressures.csv');
cold_regularPressures = cold_pressures(1:end-1,1);
cold_afterburnPressures = cold_pressures(:,2);

% Initalize air standard entropy arrays.
cold_regularEntropies = zeros(length(cold_regularTemperatures), 1);
cold_regularEntropies(1) = -3;
cold_afterburnEntropies = zeros(length(cold_afterburnTemperatures), 1);
cold_afterburnEntropies(1) = -3;

% Initalize cold air standard specific volume arrays.
cold_regularSpecificVolumes = zeros(length(cold_regularTemperatures), 1);
cold_afterburnSpecificVolumes = zeros(length(cold_afterburnTemperatures), 1);

%% Populate entropy arrays for regular case (i.e. no afterburner).

% Populate entropy arrays for regular case.
for i = 2:length(air_regularTemperatures)
    
    % Get temperature values.
    air_currentTemperature = air_regularTemperatures(i);
    air_previousTemperature = air_regularTemperatures(i-1);
    
    cold_currentTemperature = cold_regularTemperatures(i);
    cold_previousTemperature = cold_regularTemperatures(i-1);
    
    % Get interpolated values for air standard.
    [t,h,u,s,pr,vr] = thermodynamicInterpolator(air_currentTemperature);
    [t2,h2,u2,s2,pr2,vr2] = thermodynamicInterpolator(air_previousTemperature);
    
    % Get interpolated values for cold air standard.
    [t3,h3,u3,s3,pr3,vr3] = thermodynamicInterpolator(cold_currentTemperature);
    [t4,h4,u4,s4,pr4,vr4] = thermodynamicInterpolator(cold_previousTemperature);
    
    % Get change in entropies for air and cold air standard.
    air_changeInEntropy = (s2-s) - (8.314/28.97)*log(air_regularPressures(i-1)/air_regularPressures(i));
    cold_changeInEntropy = (s4-s3) - (8.314/28.97)*log(cold_regularPressures(i-1)/cold_regularPressures(i));
    
    % Compute absolute entropies for air standard and cold air standard.
    air_regularEntropies(i) = air_regularEntropies(i-1) + air_changeInEntropy;
    cold_regularEntropies(i) = cold_regularEntropies(i-1) + cold_changeInEntropy;
end

%% Populate entropy arrays for afterburner case.

% Populate entropy arrays for regular case.
for i = 2:length(air_afterburnTemperatures)
    
    % Get temperature values.
    air_currentTemperature = air_afterburnTemperatures(i);
    air_previousTemperature = air_afterburnTemperatures(i-1);
    
    cold_currentTemperature = cold_afterburnTemperatures(i);
    cold_previousTemperature = cold_afterburnTemperatures(i-1);
    
    % Get interpolated values for air standard.
    [t,h,u,s,pr,vr] = thermodynamicInterpolator(air_currentTemperature);
    [t2,h2,u2,s2,pr2,vr2] = thermodynamicInterpolator(air_previousTemperature);
    
    % Get interpolated values for cold air standard.
    [t3,h3,u3,s3,pr3,vr3] = thermodynamicInterpolator(cold_currentTemperature);
    [t4,h4,u4,s4,pr4,vr4] = thermodynamicInterpolator(cold_previousTemperature);
    
    % Get change in entropies for air and cold air standard.
    air_changeInEntropy = (s2-s) - (8.314/28.97)*log(air_afterburnPressures(i-1)/air_afterburnPressures(i));
    cold_changeInEntropy = (s4-s3) - (8.314/28.97)*log(cold_afterburnPressures(i-1)/cold_afterburnPressures(i));
    
    % Compute absolute entropies for air standard and cold air standard.
    air_afterburnEntropies(i) = air_afterburnEntropies(i-1) + air_changeInEntropy;
    cold_afterburnEntropies(i) = cold_afterburnEntropies(i-1) + cold_changeInEntropy;
end
    
%% Populate specific volume arrays for regular case (i.e. no afterburner).

for i = 1:length(air_regularTemperatures)
    
    % Get current temperatures for air and cold air standard.
    air_currentTemperature = air_regularTemperatures(i);
    cold_currentTemperature = cold_regularTemperatures(i);
    
    % Get interpolated values for air and current air standard at current
    % temperature.
    [t,h,u,s,pr,vr] = thermodynamicInterpolator(air_regularTemperatures(i));
    [t2,h2,u2,s2,pr2,vr2] = thermodynamicInterpolator(cold_regularTemperatures(i));
    
    % Populate specific volume arrays.
    air_regularSpecificVolumes(i) = (8314/28.97)*(air_regularTemperatures(i))/(air_regularPressures(i)*1000);
    cold_regularSpecificVolumes(i) = (8314/28.97)*(cold_regularTemperatures(i))/(cold_regularPressures(i)*1000);
end

%% Populate specific volume arrays for afterburner case.

for i = 1:length(air_afterburnTemperatures)
    
    % Get current temperatures for air and cold air standard.
    air_currentTemperature = air_afterburnTemperatures(i);
    cold_currentTemperature = cold_afterburnTemperatures(i);
    
    % Get interpolated values for air and current air standard at current
    % temperature.
    [t,h,u,s,pr,vr] = thermodynamicInterpolator(air_afterburnTemperatures(i));
    [t2,h2,u2,s2,pr2,vr2] = thermodynamicInterpolator(cold_afterburnTemperatures(i));
    
    % Populate specific volume arrays.
    air_afterburnSpecificVolumes(i) = (8314/28.97)*(air_afterburnTemperatures(i))/(air_afterburnPressures(i)*1000);
    cold_afterburnSpecificVolumes(i) = (8314/28.97)*(cold_afterburnTemperatures(i))/(cold_afterburnPressures(i)*1000);
end

%% Plot T-s and P-v diagrams for air standard.

figure()
regularLabels = cellstr( num2str([1:21, 1]') );
afterburnLabels = cellstr( num2str([21, 22]') );

% Plot T-s Diagrams.
subplot(1,2,1); plot(abs(air_regularEntropies), air_regularTemperatures, '.-k', 'displayName', 'No afterburner'); hold on;
labelpoints(abs(air_regularEntropies), air_regularTemperatures, regularLabels, 'W', 0.2, 'FontSize', 6);
subplot(1,2,1); plot(abs(air_afterburnEntropies), air_afterburnTemperatures, '--.k', 'displayName', 'Afterburner'); hold off;
labelpoints(abs(air_afterburnEntropies(end-2:end-1)), air_afterburnTemperatures(end-2:end-1), afterburnLabels, 'E', 0.2, 'FontSize', 7);
title('T-s Diagram');
axis square;
ylabel('Temperature (K)');
xlabel('Entropy (kJ/kg*K)');
legend('show', 'location', 'best');


% Plot P-v diagrams.
subplot(1,2,2); plot(air_regularSpecificVolumes, air_regularPressures, '.-k', 'displayName', 'No afterburner'); hold on;
labelpoints(air_regularSpecificVolumes, air_regularPressures, regularLabels, 'NE', 0.07, 1,'FontSize', 7);
subplot(1,2,2); plot(air_afterburnSpecificVolumes, air_afterburnPressures, '--.k', 'displayName', 'Afterburner'); hold off;
labelpoints(air_afterburnSpecificVolumes(end-2:end-1), air_afterburnPressures(end-2:end-1), afterburnLabels, 'N', 0.07, 1, 'FontSize', 7);

title('P-v Diagram');
axis square;
ylabel('Pressure (kPa)');
xlabel('Specific Volume (m^3/kg)');
legend('show', 'location', 'best');
                          
%% Plot T-s and P-v diagrams for cold air standard.

figure()
regularLabels = cellstr( num2str([1:21, 1]') );
afterburnLabels = cellstr( num2str([21, 22]') );

% Plot T-s Diagrams.
subplot(1,2,1); plot(abs(cold_regularEntropies), cold_regularTemperatures, '.k', 'displayName', 'No afterburner'); hold on;
labelpoints(abs(cold_regularEntropies), cold_regularTemperatures, regularLabels, 'W', 0.2, 'FontSize', 6);
subplot(1,2,1); plot(abs(cold_afterburnEntropies), cold_afterburnTemperatures, '.k', 'displayName', 'Afterburner'); hold off;
labelpoints(abs(cold_afterburnEntropies(end-2:end-1)), cold_afterburnTemperatures(end-2:end-1), afterburnLabels, 'E', 0.2, 'FontSize', 7);

title('T-s Diagram');
axis square;
ylabel('Temperature (K)');
xlabel('Entropy (kJ/kg*K)');
legend('show', 'location', 'best');

% Plot P-v diagrams.
subplot(1,2,2); plot(cold_regularSpecificVolumes, cold_regularPressures, '.k', 'displayName', 'No afterburner'); hold on;
labelpoints(cold_regularSpecificVolumes, cold_regularPressures, regularLabels, 'NE', 0.07, 1,'FontSize', 7);
subplot(1,2,2); plot(cold_afterburnSpecificVolumes, cold_afterburnPressures, '.k', 'displayName', 'Afterburner'); hold off;
labelpoints(cold_afterburnSpecificVolumes(end-2:end-1), cold_afterburnPressures(end-2:end-1), afterburnLabels, 'N', 0.07, 1, 'FontSize', 7);

title('P-v Diagram');
axis square;
ylabel('Pressure (kPa)');
xlabel('Specific Volume (m^3/kg)');
legend('show', 'location', 'best');