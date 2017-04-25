% -----------------------------------
%    HOMEWORK 05
%
%    Author:      Hunter Ducharme
%    Class:       AERO 220
%    Professor:   Dr. Raihan
%    Due date:    19 April 2017
% -----------------------------------
%%%% 

clear; close all; clc;

problem = 6;                     %#ok<NASGU> % Select a default number.
problem = input('Choose a problem (1-6): '); % Prompt the user for a number.

% Use a 'switch' statement to allow selection of different problems.
switch(problem)
    
    case 1
        %% Exercise 1: Euler's methods
        clc; clear; close all;
        
        % Define the problem statement.
        syms x y(x)
        
        % The differential equation, analytical solution, and dSolve
        % solution.
        y_prime = diff(y,x) == (cos(x)^2)*(cos(2*y)^2);
        y_analytical = @(x) (1/2)*(atan(x + (1/2)*sin(2*x) - (pi/2)) + (2*pi));
        cond = y(pi/2) == pi;
        yDSolve(x) = dsolve(y_prime, cond, 'IgnoreAnalyticConstraints', false);
        
        % Define variables for iteration.
        y_initial = pi;                   % Initial condition y(pi/2) = pi
        step_size = pi/4;
        interval = (pi/2):step_size:(3*pi); % x interval.
        nPoints = length(interval);      % Number of points in the interval.
        
        % Define y values for Heun's and Midpoint method.
        yHeun = [y_initial; zeros(nPoints-1,1)];
        yMid = [y_initial; zeros(nPoints-1,1)];
        for k = 2:nPoints
            % (1a) Improved Euler's method (Heun's method).
            yPrimeKMinus1 = (cos(interval(k-1))^2) *(cos(2*yHeun(k-1))^2);
            yHeunKEulerApprox = yHeun(k-1) + step_size*yPrimeKMinus1;
            yPrimeKEulerApprox = (cos(interval(k))^2) *(cos(2*yHeunKEulerApprox)^2);
            yHeun(k) = yHeun(k-1) + (step_size/2)*(yPrimeKMinus1 + yPrimeKEulerApprox);
            
            % (1b) Midpoint method.
            yPrimeKMinus1 = (cos(interval(k-1))^2) *(cos(2*yMid(k-1))^2);
            yKMinus1EulerApprox = yMid(k-1) + (step_size/2)*yPrimeKMinus1;
            xMidpoint = (interval(k) + interval(k-1))/2;
            yPrimeKMinus1EulerApprox = (cos(xMidpoint)^2) *(cos(2*yKMinus1EulerApprox)^2);
            yMid(k) = yMid(k-1) + step_size*yPrimeKMinus1EulerApprox;
        end
        
        % Calculate errors for Heun's and Midpoint method.
        % Take transpose of yTrue so array sizes will match.
        yTrue = yDSolve(interval)';
        heunErrors = abs((yHeun - yTrue))./abs(yTrue);
        midpointErrors = abs((yMid - yTrue))./abs(yTrue);
        
        % Plot approximations.
        figure()
        plot(interval, yTrue, '-k', 'DisplayName', 'Exact solution');
        hold on; grid on;
        plot(interval, yHeun, '--ok', 'DisplayName', 'Heun''s Method');
        plot(interval, yMid, '--*k', 'DisplayName', 'Midpoint Method');
        hold off;
        title('ODE Approximations');
        xlabel('x');
        ylabel('f(x)');
        legend('show', 'location', 'best');
        
        % Plot relative errors.
        figure()
        plot(interval, heunErrors, '-.ok','DisplayName', 'Heun''s Method');
        hold on; grid on;
        plot(interval, midpointErrors, '-.*k', 'Displayname', 'Midpoint Method');
        title('Relative errors');
        xlabel('x');
        ylabel('Relative error');
        legend('show', 'location', 'best');
          
    case 2
        %% Exercise 2: Runge-kutta and ode45
        clc; clear; close all;
        
        % Define the problem statement.
        syms x y(x)
        
        % The differential equation, analytical solution, and dSolve
        % solution.
        y_prime = diff(y,x) == (cos(x)^2)*(cos(2*y)^2);
        y_analytical = @(x) (1/2)*(atan(x + (1/2)*sin(2*x) - (pi/2)) + (2*pi));
        cond = y(pi/2) == pi;
        yDSolve(x) = dsolve(y_prime, cond, 'IgnoreAnalyticConstraints', false);
        
        % Define variables for iteration.
        y_initial = pi;                   % Initial condition y(pi/2) = pi
        step_size = pi/4;
        interval = (pi/2):step_size:(3*pi); % x interval.
        nPoints = length(interval);      % Number of points in the interval.
        
        % (2a) 4th order Runge-Kutta
        yRungeKutta = [y_initial; zeros(nPoints-1, 1)];
        f = @(x,y) (cos(x)^2)*(cos(2*y)^2);
        for k = 2:nPoints
            k1 = f(interval(k-1), yRungeKutta(k-1));
            k2 = f(interval(k-1) + (step_size/2), yRungeKutta(k-1) + (k1*step_size/2));
            k3 = f(interval(k-1) + (step_size/2), yRungeKutta(k-1) + (k2*step_size/2));
            k4 = f(interval(k), yRungeKutta(k-1) + (k3*step_size));
            yRungeKutta(k) = yRungeKutta(k-1) + (step_size/6)*(k1 + 2*k2 + 2*k3 + k4);
        end
        
        % (2b) MATLAB ODE45
        [xODE, yODE] = ode45(f, [interval(1), interval(end)], y_initial);
    
        % Calculate errors.
        % Take transpose of yTrue so array sizes will match.
        yTrue = yDSolve(interval)';
        rungeKuttaErrors = abs((yRungeKutta - yTrue))./abs(yTrue);
        ode45Errors = abs((yODE - yDSolve(xODE)))./abs(yDSolve(xODE));
        
        % Plot approximations.
        figure()
        plot(interval, yTrue, '-k', 'DisplayName', 'Exact solution');
        hold on; grid on;
        plot(interval, yRungeKutta, '--^k', 'DisplayName', '4th order Runge Kutta');
        plot(xODE, yODE, '--.k', 'DisplayName', 'ODE45')
        hold off;
        title('ODE Approximations');
        xlabel('x');
        ylabel('f(x)');
        legend('show', 'location', 'best');
        
        % Plot relative errors.
        figure()
        plot(interval, rungeKuttaErrors, '-.^k', 'DisplayName', '4th order Runge Kutta');
        hold on; grid on;
        plot(xODE, ode45Errors, '-..k', 'DisplayName', 'ODE45')
        hold off;
        title('Relative Errors');
        xlabel('x');
        ylabel('Relative error');
        legend('show', 'location', 'best');
        
    case 3
        %% Exercise 3: 
        clc; clear; close all;        
        
    case 4
        %% Exercise 4: 
        clc; clear; close all;
        
    case 5
        %% Exercise 5: 
        clc; clear; close all;

    case 6
        %% Exercise 6: 
        clc; clear; close all;
        
    otherwise
        error('Invalid Problem Number');
end