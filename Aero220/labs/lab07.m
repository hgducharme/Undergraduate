%% 1. Use bisection method to find roots of cosh(x)cos(x)
clc; clear; close;

f = @(x) cosh(x)*cos(x);         % Function to find roots of.
a = [-2, 0];                     % Lower bound for 2 intervals.
b = [0, 2];                      % Upper bound for 2 intervals.
error = 10^(-4);                 % Error tolerance.
counter = zeros(1, length(a)); % Iteration counter.
c = zeros(1, length(a));         % Initialize midpoint variable.

% For two different intervals [-5,0] and [0,5].
for i = 1:length(a)
    
    % Calculate the root of f(x) in the interval.
    while ( abs( f(c(i)) ) > error )
        % Calculate midpoint.
        c(i) = (a(i)+b(i))/2; 
        counter(i) = counter(i) + 1;

        % If c is root, break the loop.
        if f(c(i)) == 0,
            break; 
        % elseif f(a) and f(c) have opposite signs, change upper bound to c.    
        elseif ( f(a(i))*f(c(i)) < 0 )
            b(i) = c(i);
        % else, change lower bound to c.
        else
            a(i) = c(i);
        end
    end
end

disp(c)

%% 2. Use secant method to find roots of cosh(x)cos(x)
clc; clear; close;

f = @(x) cosh(x)*cos(x); 
x(1) = f(0);
x(2) = f(5);
error = 10^(-4);
counter = 0;
root = x(counter);

while ( abs(f(root)) > error )
    x(i) = x(i-1) - ( f(x(i-1)) )*( x(i-1) - x(i-2) ) / ( f(x(i-1)) - f(x(i-2)) );
    
end

disp(root)