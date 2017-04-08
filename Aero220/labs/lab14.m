%% Problem 1: Use Simpson's method to evaluate the integral
clc; clear; close all;

f = @(x) (pi.^(-2))*(x.^2).*(sin(x));
a = 0;    % Lower bound
b = 2*pi; % Upper bound

% 1a) Calculate the true integral analytically.
fint = integral(f, a, b);

% 1b) Use Simpson's method with n = 5 partitions.
n5 = 5;                      % partitions = 5
x5 = linspace(a,b,(2*n5+1)); % Points for 5 partitions
summation5 = 0;              % Value of the summations for 5 partitions

% 1c) Use Simpson's method with n = 10 partitions.
n10 = 10;                      % partitions = 10
x10 = linspace(a,b,(2*n10+1)); % Points for 10 partitions
summation10 = 0;               % Value of the summations for 10 partitions

% Combine computations for n = 5 and n = 10 partitions.
for k = 1:(n10-1)
    if k < n5
        summation5 = summation5 + 4*f(x5(2*k+1)) + 2*f(x5(2*k));
    end
    
    summation10 = summation10 + 4*f(x10(2*k+1)) + 2*f(x10(2*k));
end

% Area using 5 partitions.
area_simpson_5 = (1/3)*((b-a)/(2*n5))*(summation5 + f(x5(1)) + f(x5(2*n5)));
% Area using 10 partitions.
area_simpson_10 = (1/3)*((b-a)/(2*n10))*(summation10 + f(x10(1)) + f(x10(2*n10)));

%% Problem 2: Find volumetric flow rate
clc; clear; close all;

f = @(r,v) 2*pi*r*v; % Integrand
dia = 40;            % cm; dia of the pipe
R = [0, 2.5, 5, 7.5, 10, 12.5, 15, 17.5, 20];           % radii data
V = [0.914,0.89,0.847,0.795,0.719,0.543,0.427,0.204,0]; % velocity data

% 1a) Fit a curve to the data and use Simpson's method on the data.
f_data = zeros(1,length(R)); % Volumetric flow rate at each R,V touple.
hold on;
for i = 1:length(R)
    f_data(i) = f(R(i), V(i)); % Store volumetric flow rate at each instant
    plot(R(i), f(R(i),V(i)), '*');
end
hold off;

% Fit a curve to the data.
p = polyfit(R, f_data, 4);
y = polyval(p, R);

% Perform Simpson's method on y


% 1b) Use Simpson's method directly on the data.