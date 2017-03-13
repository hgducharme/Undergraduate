%% Use Regula-Falsi method to find roots of a function.
clc; clear; close;

f = @(x) x^2 - 2*x - 3;     % Function to find roots for.
a = [-10, 0];               % Lower bound.
b = [0, 10];                % Upper bound.
xrfp = zeros(1, length(a)); % Regula-falsi point.
error = .01;                % Error tolerance

% For the ith interval,
for i = 1:length(a)
    %INFITITE LOOP %% Look for root until error tolerance is met.
    while abs( f(xrfp(1,i)) ) > error
        % Calculate the regula-falsi point.
        xrfp(i,i) = a(1,i) - f(a(1,i))*(b(1,i)-a(1,i))/(f(b(1,i)) - f(a(1,i)));

        % If a and xrfp give the same sign for y, then move a up to xfrp.
        if sign(f(xrfp(1,i))) == sign(f(a(1,i)))
            a(1,i) = xrfp(1,i);
        % Else, move b down to xfrp.
        else
            b(1,i) = xrfp(1,i);
        end
    end
end

%% Use Fixed Point Iteration Method to find roots of a function.
clc; clear; close;

g1 = @(x) sqrt(2*x +3);
g2 = @(x) 3/(x-2);
g3 = @(x) (x^2 -3)/(2);
x0= 1;
xold = [0, 0, 0];
error = .01;
n = 0;

while abs(g1(x0)) > error
    x = sqrt(2*x+3);
    xold = x;
    n = n+1;
end