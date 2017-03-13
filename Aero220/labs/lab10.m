%% 1. Use Newton's Method to find the root of an equation.
clc; clear; close;

% 1.1 Define and plot the function.
syms x
f(x) = x.^3 + (4*x.^2) - 10; % Define the polynomial function.
f1(x) = diff(f);             % Find first derivative of the function.
plot(-15:15, f(-15:15));     % Plot the function to find where the root lies.

% 1.2 Find the root and store each calculated root in an array.
a = 10;                   % Initial guess.
x(1) = a - f(a)/f1(a); % Initial root approximation.
e(1) = abs(x(1) - a);     % Initial approximation error.
error = 10^(-9);          % Error tolerance.
k = 1;                    % Iteration counter.

while (f(x(k)) > error)
    % Calculate the approximated root.
    x(k+1) = x(k) - f(x(k))/f1(x(k));
    
    % Calculate the approximation error and store it.
    e(k+1) = abs(x(k+1) - x(k));
    
    % Update counter.
    k = k + 1;
end

% 1.3 Find the order of convergence.
alpha = log(e(k)/e(k-1)) / log(e(k-1)/e(k-2));

%% 2. Use AItken Acceleration Method to find the roots of a function.
clc; clear; close;

g = @(z) 10./(z.^2 + 4*z); % Define the function.
x0 = 10;                  % Initial guess for root.
x1 = g(x0);
x2 = g(x1);
x_hat = x0 - ((x1 - x0)^2)/(x2 - 2*x1 + x0); % Value of root.
error = 10^(-9);     % Error tolerance.
k = 3;               % Iteration counter.
e(1) = abs(x1 - x0); % 1st error calculation.
e(2) = abs(x2 - x1); % 2cd error calculation.


while abs(x_hat - x2) > error
   % Calculate the root approximation.
   x_hat = x0 - ((x1 - x0)^2)/(x2 - 2*x1 + x0);
   
   % Calculate the error and store it.
   e(k) = abs( x_hat - x2 );
   
   % Update variables and counter.
   x0 = x_hat;
   x1 = g(x0);
   x2 = g(x1);
   k = k + 1;
end

alpha = log(e(k-1)/e(k-2)) / log(e(k-2)/e(k-3));