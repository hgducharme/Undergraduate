%% Problem 1: Damped spring-mass system
clc; clear; close all;

% Define ODE
syms x(t) c m k
v = diff(x,t); % 1st derivative of x
ode = diff(x,t,2) == -(k*x/m) - (c/m)*v;
m = 20;           % kg, mass
c = [5, 40, 200]; % N s/m, damping coefficients [under, critical, over]
k = 20;           % N/m, spring constant
t = 0:15;         % s, time range

% Inital conditions for ODE
cond = [x(1) == 1, v(0) == 0];

% 1a) Use dsolve() to solve the ODE.
xSol = dsolve(ode, cond);

% 1b) Convert 2nd order ODE to a system of 1st order ODEs & use Euler's
% method.
syms x(t)
v = diff(x,t);
a = diff(v,t);

% 1c) Plot the displacement vs. time

%% Proglem 2: Motion of a projectile

% Define ODE
syms v(t) g x R
ode = diff(v,t) == -g*(R^2)*((R+x)^(-2));
g = 9.81;      % m/s^2, gravity
R = 6.37*10^6; % m, Earth's radius

% Initial conditions for ODE
cond = [v(0) == 1400];

% 2a) Use Euler's method to find max height.
h = 0.01;                % Step size
t = 0:h:1000;            % Time values
y = zeros(1, length(t)); % Initalize solution vector

% THIS IS WRONG
for i = 2:length(t)
    y_prime = (-g)*( (R+x(i-1))^(-2) );
    y(i) = y(i-1) + h*y_prime;
end