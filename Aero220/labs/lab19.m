%% 1) Solve the following differential equation
clc; clear; close all;

syms y(x)
ode = diff(y,x) == 1 + (x^2) + y;
cond = [y(0) == 1];
h = 0.01;
x = 0:10;

% 1a) Use dsolve()
sol = dsolve(ode, cond);

% 1b) Use Huen's method
yHeun = zeros(length(x), 1);
yHeun(1) = ode(0);
for k = 2:length(x)
    % Averaging
    ypkm1 = 1 + x(k-1)^2 + yHeun(k-1); % Function f(x,y)
    
end

% 1c) Use Midpoint method
yMid = zeros(length(x), 1);
yMid(1) = ode(0);

for k = 2:length(x)
    ypkm1 = 1 + x(k-1)^2 + yMid(k-1); % Function f(x,y)
    xm = (1/2)*(x(k) + x(k-1));
    ym = yMid(k-1) + (h/2)*ypkm1;
    ymp =1 + xm^2 + ym;
    yMid(k) = yMid(k-1) + h*ymp;
end

plot(x, yMid, '-b*');

% 1d) Use 4th order Runge Kutta
yRungeK = [ode(0); zeros(length(x)-1, 1)];
f = @(x,y) 1 + x^2 + y;
for k = 2:length(x) 
    k1 = f(x(k-1), yRungeK(

% 1e) Use builtin ode45