clc; clear; close;

% Load force and length vectors.
data = load('CFUdata.mat');
force = data.force;
length = data.length;

% Calculate area of the rod.
dia = .505;            % in
area = (pi/4)*(dia^2); % in^2

%%% 1. Calculate stress and strain for each force, length tuple.

% Calculate stress for each force value.
stress = zeros(size(force, 1), 1);
for i = 1:size(force, 1)
    stress(i, 1) = force(i, 1)/area;
end

% Calculate strain for each length value.
strain = zeros(size(length, 1), 1);
for i = 1:size(length, 1)
    strain(i) = (1/length(1))*(length(i) - length(1));
end

%%% 2. Create a stress vs. strain plot.
x = strain;
y = stress;
plot(x, y, 'k-o');
hold on;

%%% 3. Add a title and axis labels.
title('Stress vs. Strain for Material X');
xlabel('Strain');
ylabel('Stress');

%%% 4. Mark the yield stress on the graph with a red asterisk.
plot(0.00469999999999993, 37444.5508695764, 'r*', 'LineWidth', 1.0005);