%{

AERO 220 Spring 2017
Instructor: Dilshad Raihan, dilshadraihan@gmail.com 
TA: Ralston Fernandes, ralston92@tamu.edu


LAB 3: Analytical vs. Numerical Methods

%}

%% Problem 1: Setup by hand the differential equation for a skydiver.
%% Problem 2: Use syms and initial condition v(0) = 0 to find differential equation.
clc; clear; close;

m = 68.1;  % mass, kg
Cd = 12.5; % drag coefficient, kg/s
g = 9.81;  % gravity, m/s^2

% Solve the differential equation.
syms v(t)
eqn = diff(v, t) == g - Cd*v/m;
cond = v(0) == 0;  % initial condition
v(t) = dsolve(eqn, cond);

% Plot the analytical differential equation.
t = (0:0.5:20);
plot(t, v(t));

%% Problem 3: Plot a numerical version of the differential equation.

vNumerical = zeros(length(v(t)), 1);
vNumerical(1) = 0;

for i=1:length(v(t)) - 1
    vNumerical(i+1) = vNumerical(i) + (g - (Cd/m)*vNumerical(i))*(t(i+1) - t(i));
end

hold on;
plot(t, vNumerical, 'g--');