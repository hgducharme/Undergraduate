%% Problem 1: Estimate the following integral
clc; clear; close all;

% Function in question
f = @(x) ( (x.^2)/(pi.^2) ).*sin(x);
a = 0;    % Lower bound
b = 2*pi; % Upper bound

%%%% 1a. Calculate integral analytically
f_int = integral(f, 0, 2*pi);

%%%% 1b. Use midpoint method to approximate integral

% 10100 partitions
n1 = 10100;                % Number of partitions in the interval
x1 = linspace(a, b, n1+1); % x values along the interval
mpSum1 = 0;
for i = 2:length(x1)
    mpSum1 = mpSum1  + f((1/2).*(x1(i) + x1(i-1)));
end
% Account for (b-a)/n in the formula.
mpSum1 = (mpSum1).*(1/n1)*(b-a)

% 1000 partitions
n2 = 1000;                 % Number of partitions in the range
x2 = linspace(a, b, n2+1); % x values along the interval
mpSum2 = 0;
for i = 2:length(x2)
    mpSum2 = mpSum2  + f((1/2).*(x2(i) + x2(i-1)));
end
% Account for (b-a)/n in the formula.
mpSum2 = (mpSum1).*(1/n2)*(b-a)

% Relative error for the 2 different partition values
rel_error = abs(mpSum2 - mpSum1)/abs(mpSum1)

%%%% 1c. Use trapezoid method to approximate integral

% 10100 partitions
n3 = 10100;
x3 = linspace(a,b,n3 + 1);
trapSum1 = 0;
for i=2:length(x3)
    trapSum1 = trapSum1 + ( (x3(i) - x3(i-1))*(f(x3(i)) + f(x3(i-1))));
end

% 1000 partitions
n4 = 1000;
x4 = linspace(a,b,n4 + 1);
trapSum2 = 0;
for i=2:length(x4)
    trapSum1 = trapSum1 + ( (x4(i) - x4(i-1))*(f(x4(i)) + f(x4(i-1))));
end

relativeErrorTvsMP = abs(mpSum1 - trapSum1)

%% Problem 2: Find total mass from the density integral