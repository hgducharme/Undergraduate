% By submitting this assignment, I agree to the following:
% “Aggies do not lie, cheat, or steal, or tolerate those who do”
% “I have not given or received any unauthorized aid on this assignment”
%
% Name: Hunter Ducharme
% Section: 533
% Team: 22
% Assignment: A simple plot
% Date: 4 December 2016

r1 = 9; % Ohms
r2 = 19; % Ohms

% Plot Ohm's Law for varying currents and for two different R values
x = 0:2:20;
y1 = r1*x;
y2 = r2*x;
plot(x, y1, x, y2, '--');
title('Ohm''s law for Two Resistance Values');
xlabel('Current (A)');
ylabel('Voltage (V)');
legend('9 Ohms', '19 Ohms');
