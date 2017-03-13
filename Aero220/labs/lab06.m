%% 1. Taylor Series Approximation
clc; clear; close;

% 1.1 Approximate f(x) = 1/x where x = 2.5, by using the taylor series
% expansion of 1/x around 2.

f = @(x) 1/x;      % Define f(x) = 1/x.
x0 = 2.5;          % Approximate f(x) at x0.
a = 2;             % Number to expand taylor series around.
terms = 4;         % Number of taylor series terms to use.
approximation = 0; % Initialize approximation variable.
for i = 1:terms
    approximation = approximation + (power(-1,i-1)*power(2,-1-(i-1))*power((-a+2.5),i-1));
end

% 1.2 Print the exact value of f(x0), the absolute error, and the relative
% error.

realValue = (1/2.5);
absoluteError = abs(realValue - approximation);
relativeError = (1/realValue)*abs(approximation - realValue);

fprintf('Exact value of (1/2.5): %f\n', realValue );
fprintf('Absolute error: %f\n', absoluteError);
fprintf('Relative error: %f\n\n', relativeError);

% 1.3 Generalze the taylor series approximation for any given f(x) and the
% amount of terms.
clear; clc; close; % DELETE THISSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

syms x
fprintf('Taylor series formula: ((x-a)^k / (k!)) * f^k(x)\n');
func = input('Input f(x): ');
a = input('Input (a): ');
x0 = input('Input (x): ');
terms = input('Input the number of desired terms: ');
f = @(x) func;


approxValue = 0;                    % Initialize approxValue variable.
trueValue = vpa(subs(f(x), x, x0)); % vpa() returns numerical value.
errorMatrix = zeros(terms, 1);      % Collect the error for each additional term.
for k=1:terms
    % Calculate the kth derivative of f(x).
    derivative = diff(f(x), k-1);
    
    % Evaluate the kth derivative at 'a'.
    derivativeValue = vpa(subs(derivative, x, a));
    
    % Taylor series formula.
    approxValue = approxValue + power(x0 - a, k-1)*(1/factorial(k-1))*derivativeValue;
    
    % Calculate the error and store it in the matrix errorMatrix.
    errorMatrix(k) = (1/trueValue)*abs(trueValue - approxValue);
end

%disp(approxValue)
%disp(vpa(subs(f(x), x, x0))) In order for this to correctly ouput you must
%sub x0 for x using subs() and use vpa() to return a numerical answer.

plot(1:terms, errorMatrix, 'bo--');

%% 2. Round-off Error
clc; clear; close;

% 2.1 
x = rand(1);                 % Generate a random number between 0 and 1.
y = ((((x*5)/(5))+1-1)*2)/2; % Perform algebra that all cancels out.
fprintf('x = %f\n', x);
fprintf('y = %f\n', y);
disp(x==y)                   % Even though all algebra cancels out, are they still equivelant?

% 2.2 Evaluate and plot alpha = (1+r^2)-2r-r^2 for 1 < r < 1e16.
a = 1;   % Lowest value in the range.
b= 1e16; % Highest value in the range.

% Create range of numbers.
r = (b-a)*rand(1000,1) + a;

% Store values of alpha for each value of r.
alpha = zeros(size(r,1), 1);

for i = 1:size(r, 1)
    alpha(i) = (1+r(i))^2 - 2*r(i) - r(i)^2;
end

loglog(r, alpha, 'bx'); grid on;