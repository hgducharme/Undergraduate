clc; clear; close;

% 1. Plot the funciton and make an initial guess for Newton's method.
g = -9.81; % m/s^2
v0 = 20;  % m/s
x = 35;   % m
y0 = 2;   % m
y = 1;   % m

% Define function and function's derivative.
syms t 
k = @(t) y - (tan(t).*x) + (g.*power(x,2)).*(2*(v0.^2)*(cos(t).^2)).^(-1) - y0;
dk = diff(k, t);   % First derivative.
dk2 = diff(k,2,t); % Second derivative.

% Plot y vs. theta.
t = (0:0.01:pi/3);
plot(t, k(t)); 
grid on;
xlabel('Radians');
ylabel('Height (m)');

% 2. Use newton's method to find the smallest value of t.
error = 10^(-5); % Error tolerance.
tMin = 50;      % radians. Initial guess.
n = 2;           % Iteration counter.

while (abs(k(tMin)) > error)
    dk = eval(subs(dk, tMin, t));
    tMin = tMin - ( k(tMin) / dk(tMin) );
    n = n+1;
end

% 3. Calculate the order of convergence of Newton's method.
condition =  0;