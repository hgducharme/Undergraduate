function [ firstOrderDE ] = evaluateThetaDoubleDotWIP( ~, x)
%EVALUATETHETADOUBLEDOT This function takes a range of time values and a
%set of initial conditions in, and then converts the second order
%differential equation to a first order differential equation.
%   INPUT:
%      x = [x(1); x(2)] = [theta; thetaDot]
%      Note that, dx/dt =  [x'(1); x'(2)] = [thetaDot; thetaDoubleDot];
%   OUTPUT:
%      firstOrderDE = dx/dt = [x(2), thetaDoubleDot];

% Define constants
m = 1;                   % kg
L = 1;                   % m
r = 0.05;                % m
g = 9.806;               % m/s^2
k = 25;                  % N/m
lNaught = 1;             % m
omegaValue = x(3);       % rad/s

% Calculate the spring force since it's a symbolic variable:
%%% if theta < pi, keep spring force sign the same
%%% if theta >= pi, flip the sign of the spring force
springForceVertical = ( (x(1) < pi) - (x(1) >= pi) )*(2*L*k*(cos(x(1)/2) - lNaught));
springForceHorizontal = ( (x(1) < pi) - (x(1) >= pi) )*(2*L*k*(sin(x(1)/2) - lNaught));

% Initialize the matrix to hold the first order variables.
firstOrderDE = zeros(length(x),1);

% x1' = thetaDot
firstOrderDE(1) = x(2);

% Substitute theta and thetaDot with x(1) and x(2), respectively.
% x2' = thetaDoubleDot = f(theta, thetaDot) = f( x(1), x(2) )
firstOrderDE(2) = -(2*(6*L*springForceVertical*sin(x(1)/2) - 6*L*springForceHorizontal*cos(x(1)/2) + 12*L*g*m*sin(x(1)/2) + 2*L^2*m*omegaValue^2*cos(x(1)/2)*sin(x(1)/2) - 3*L^2*m*x(2)^2*cos(x(1)/2)*sin(x(1)/2) + 3*m*omegaValue^2*r^2*cos(x(1)/2)*sin(x(1)/2)))/(L^2*m + 3*m*r^2 - 3*L^2*m*cos(x(1)/2)^2 - 15*L^2*m*sin(x(1)/2)^2);

% x3' = omegaDot = 0;
firstOrderDE(3) = 0;

firstOrderDE = [firstOrderDE(1); firstOrderDE(2); firstOrderDE(3)];
end