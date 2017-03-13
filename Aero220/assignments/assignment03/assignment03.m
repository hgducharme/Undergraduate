%% Header

% -----------------------------------
%    HOMEWORK 3
%
%    Author:      Hunter Ducharme
%    Class:       AERO 220
%    Professor:   Dr. Raihan
%    Due date:    10 Mar 2017
% -----------------------------------
%%%% 

clear; close all; clc;

problem = 6;                     %#ok<NASGU> % Select a default number.
problem = input('Choose a problem (1-6): '); % Prompt the user for a number.

% Use a 'switch' statement to allow selection of different problems
switch(problem)
    
    case 1
        %% Exercise 1: Find steady state concentration with fixed-point iteration
        clc; clear; close all;
        
        % Equation constants
        V = 10^6; % m^3
        Q = 10^5; % m^3/yr
        W = 10^6; % g/yr
        k = 0.25; % (g^.5)/(yr*m^(1.5))
        
        % Fixed point iteration data
        f = @(c) W - Q*c - k*V*sqrt(c);   % Mass balance equation
        g = @(c) (1/Q)*(W - k*V*sqrt(c)); % x = g(x)
        c0 = 4;                           % g/m^3, inital guess
        tol = 0.1;                        % error tolerance
         
        while abs(f(c0)) > tol
            c0 = g(c0);
        end
        
    case 2
        %% Exercise 2: Find the root of f(x)
        clc; clear; close all;
        
        % 2a. Use Newton's method, compute order of convergence and error
        % constant
        syms x
        g(x) = (exp(-x) - 3 + x^3 -2*x); % Function to find root of
        f_prime = diff(g, x);             % 1st derivative of f(x)
        x0 = 2.3;                         % Initial guess
        x1 = x0 - (g(x0)/f_prime(x0));    % Root approximation
        error1 = zeros(1,5);              % Absolute errors
        
        for i = 1:5
            x1 = x0 - (g(x0)/f_prime(x0));
            error1(1,i) = abs(x1 - x0);
            x0 = x1;
        end
        
        alpha = log(error1(1,5)/error1(1,4))/log(error1(1,4)/error1(1,3)); % Order of convergence
        lambda = error1(1,2)/(error1(1,1)^alpha);                          % Asymptotic error constant
        
        % 2b. Does Newton's method converge for range [-3,3]?
        syms k
        g(k) = (1/2)*(exp(-k) - 3 + k^3);             % x = g(x)
        g_prime = g(k)*diff(g, k, 2)/(diff(g, k)^2);  % Derivative approximation
        range = linspace(-3,3,1000);                  % Interval to check convergence on
        g_prime_eval = eval(subs(g_prime, k, range)); % Evaluate derivative on the interval
        plot(range, abs(g_prime_eval));               % Plot the result
        hold on;
        plot([-3 3], [1 1], ...
            'LineWidth', 1.25);                       % Reference line
        hold off;
        ylim([0,2]);
        title('Newton''s Condition of Convergence');
        xlabel('Domain');
        ylabel('|g''(x)|');
        
        %%% No, it does not converge because the magnitude of g'(x) is not
        %%% less than 1 at all points on the region.
        
    case 3
        %% Exercise 3: Compute FWD, CNTRL, and BKWRD differences for cos(x)
        clc; clear; close all;
        
        g = @(x) cos(x); % Function in question
        x = pi/4;        % Point to evaluate function at
        h = pi/12;       % Step size
        a = -sin(x);     % Actual value of f'(x)
        
        % Forward difference approximations
        fwdDiff2pt = (1/(h))*(g(x+h) - g(x));
        fwdDiff3pt = (1/(2*h))*( (4*g(x+h)) - g(x+2*h) - 3*g(x));
        fwdDiff4pt = (1/(6*h))*((18*g(x+h)) - (9*g(x+2*h)) + (2*g(x+3*h)) - 11*g(x));
        % Forward difference relative errors
        fwd2ptError = abs(fwdDiff2pt - a)/abs(a);
        fwd3ptError = abs(fwdDiff3pt - a)/abs(a);
        fwd4ptError = abs(fwdDiff4pt - a)/abs(a);
      
        % Backward difference approximations
        bckDiff2pt = (1/h)*(g(x) - g(x-h));
        bckDiff3pt = (1/(2*h))*(3*g(x) +g(x-2*h) - 4*g(x-h));
        bckDiff4pt = (1/(6*h))*((11*g(x)) - (18*g(x-h)) + (9*g(x-2*h)) - (2*g(x-3*h)));
        % Backward difference relative errors
        bck2ptError = abs(bckDiff2pt - a)/abs(a);
        bck3ptError = abs(bckDiff3pt - a)/abs(a);
        bck4ptError = abs(bckDiff4pt - a)/abs(a);
        
        % 3-point central difference approximation
        ctrlDiff3pt = (1/(2*h))*(g(x+h) - g(x-h));
        % Central difference relative error
        ctrl3ptError = abs(ctrlDiff3pt - a)/abs(a);
        
        % Make a table of all the results
        Method = {'Central 3pt'; 'Forward 2pt'; 'Forward 3pt'; 'Forward 4pt'; ...
            'Backward 2pt'; 'Backward 3pt'; 'Backward 4pt'};
        Calculated = [ctrlDiff3pt; fwdDiff2pt; fwdDiff3pt; fwdDiff4pt; ...
            bckDiff2pt; bckDiff3pt; bckDiff4pt];
        Actual(1:7, 1) = a;
        RelativeError = [ctrl3ptError; fwd2ptError; fwd3ptError; fwd4ptError; ...
            bck2ptError; bck3ptError; bck4ptError];
        
        T = table(Calculated, Actual, RelativeError, 'RowNames', Method);
        disp(T)
        
    case 4
        %% Exercise 4: Show that the error of 2pt fwd & bckwd is O(h)
        clc; clear; close all;
        % Done on paper.
        
    case 5
        %% Exercise 5: Compare finitie difference approximations
        clc; clear; close all;
        
        g = @(x) exp(-2*x) - x;     % Function in question
        x = 2;                      % Approximate f'(x=2)
        dx = linspace(.01,.5,1000); % Interval: [.01, .05] broken into 1000 values
        a = -2*exp(-2*x) - 1;       % Actual value of f'(x=2)
        
        fwd3ptError = zeros(1, length(dx));
        bck3ptError = zeros(1, length(dx));
        ctrl3ptError = zeros(1, length(dx));
        
        % 5a. Find actual derivative. Done on paper.
        % 5b. Plot absolute error of 3 point fwd, bckwd, and central
        % approximations on a logarithmic scale.
        
        for i=1:length(dx)
            % Compute forward, backward, and central difference for given
            % step size h = dx(i).
            fwdDiff3pt = (1/(2*dx(i)))*( (4*g(x+dx(i))) - g(x+2*dx(i)) - 3*g(x));
            bckDiff3pt = (1/(2*dx(i)))*(3*g(x) +g(x-2*dx(i)) - 4*g(x-dx(i)));
            ctrlDiff3pt = (1/(2*dx(i)))*(g(x+dx(i)) - g(x-dx(i)));
            
            % Compute absolute errors for each finite difference.
            fwd3ptError(i) = abs(fwdDiff3pt - a);
            bck3ptError(i) = abs(bckDiff3pt - a);
            ctrl3ptError(i) = abs(ctrlDiff3pt - a);
        end
        
        % Plot absolute errors of each finite difference.
        semilogy(dx, bck3ptError, '.', 'DisplayName', 'Backward difference');
        hold on;
        semilogy(dx, fwd3ptError, '--', 'DisplayName', 'Forward difference');
        hold on;
        semilogy(dx, ctrl3ptError, '-', 'DisplayName', 'Central difference');
        title('Absolute Errors of 3-point Finite Difference Approximations');
        legend('show', 'Location', 'best');
        xlabel('Step size, h');
        ylabel('Absolute error');
        
    case 6
        %% Exercise 6: Richardson Extrapolation
        clc; clear; close all;
        
        % 6a. Approximate second derivative of sin^2(x/2)
        g = @(x) (sin(x/2))^2; % Function in question
        x = 0;                 % Point to evaluate at
        h1 = 0.1;              % Step size 1
        h2 = 0.01;             % Step size 2
        
        % Second derivative approximation
        g2 = @(h) (1/(h^2))*(g(x+h) + g(x-h) - 2*g(x));
        g2_h1 = g2(h1); % f''(x) evaluated at h1
        g2_h2 = g2(h2); % f''(x) evaluated at h2
        % Richardson extrapolation for part A
        richExA = (((10^2 - 1)^(-1)))*( (10^2)*g2(h2) - g2(h1) );
        
        % 6b. Use Richardson Extrapolation to approximate f(x) = 2x^2 + 1
        f = @(x) 2*x^2 + 1;          % Function in question
        x = [0 0.1 0.2 0.3 0.4 0.5];
        h3 = 0.3;                    % Step size 3
        h4 = 0.1;                    % Step size 4
        
        % First derivative approximation
        f1 = @(x, h) (1/h)*(f(x+h) - f(x)); 
        f1_h3 = f1(x(1), h3); % f'(x) evaluated at h3
        f1_h4 = f1(x(1), h4); % f'(x) evaluated at h4
        % Richardson Extrapolation for part B
        richExB = (1/2)*(3*f1(x(1),h4) - f1(x(1),h3));
        
    otherwise
        error1('Invalid Problem Number');
end