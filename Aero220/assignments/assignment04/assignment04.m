% -----------------------------------
%    HOMEWORK 04
%
%    Author:      Hunter Ducharme
%    Class:       AERO 220
%    Professor:   Dr. Raihan
%    Due date:    31 Mar 2017
% -----------------------------------
%%%% 

clear; close all; clc;

problem = 6;                     %#ok<NASGU> % Select a default number.
problem = input('Choose a problem (1-6): '); % Prompt the user for a number.

% Use a 'switch' statement to allow selection of different problems.
switch(problem)
    
    case 1
        %% Exercise 1: Trapezoid and Midpoint
        clc; clear; close all;
        
        % 1a) Derive the trapezoid method -- done on paper.
        % 1b) Use midpoint method for f(x) = e^(-x^2).
        f = @(x) exp(-x^2);
        n = randi(20);            % Random number of partitions.
        p = n + 1;                % The number of corresponding points.
        x = sort(200*rand(1, p)); % Random numbers between 0 and 200 to act as x values, sorted in ascending order.
        
        approximation = 0; % Approximated value of the integral.
        for i = 2:p
            a = x(i-1); % Left x value of the partition.
            b = x(i);   % Right x value of the partition.
            approximation = approximation + ((b-a))*f( (b+a)/2 );
        end
        
    case 2
        %% Exercise 2: Evaluate an integral analytically
        clc; clear; close all;
        
        % 2a) Evaluate the integral analytically -- done on paper.
        % 2b) Evalue the integral using midpoint and trapezoidal methods.
        f = @(x) sqrt(x);
        f_trueValue = integral(f, 0, 9);
        
        midpoint_values = zeros(1, 10);
        trapezoid_values = zeros(1,10);
        midpoint_errors = zeros(1,10);
        trapezoid_errors = zeros(1,10);
        for n = 1:10               % Number of partitions/subintervals.
            p = n + 1;             % Number of points.
            x = linspace(0, 9, p); % x coordinates.
            y = f(x);              % y coordinates.
            a = x(1);              % Lower limit.
            b = x(p);              % Uspper limit.
            dx_mp = (b-a)/(n);     % Step size for midpoint method.
            dx_tm = (b-a)/(2*n);   % Step size for trapezoidal method.

            % Trapezoid calculations.
            trapezoid_values(n) = (dx_tm)*(y(1) + 2*sum(y(2:end-1)) + y(end));
            trapezoid_errors(n) = abs(f_trueValue - trapezoid_values(n));
            
            % Temporary sum for the current iteration of n.
            midpoint_temp = 0;
            for i = 2:p
                ai = x(i-1);
                bi = x(i);
                
                % Midpoint calculations.
                midpoint_temp = midpoint_temp + (dx_mp)*f((bi+ai)/2);
            end
            midpoint_values(n) = midpoint_temp;
            midpoint_errors(n) = abs(f_trueValue - midpoint_values(n));
        end
        
        % 2c) Plot the absolute errors vs. the number of partitions used.
        plot(1:10, midpoint_errors, '-s', 'DisplayName', 'Midpoint method');
        hold on;
        plot(1:10, trapezoid_errors, '--s', 'DisplayName', 'Trapezoid method');
        hold off;
        title('Absolute error vs. Number of partitions');
        ylabel('Absolute error');
        xlabel('Number of partitions');
        legend('show');
        
    case 3
        %% Exercise 3: Numerical Integration
        clc; clear; close all;       
        
        % 3a) Use 5-point Simpson's method -- done on paper.
        % 3b) Use trapezoidal method and 2 subintervals -- done on paper.
        % 3c) Compute absoulte errors from part (3a) & (3b) to 5 sig figs.
        trueValue = (pi/2);
        
        simpsonValue = 47/30;
        trapezoidValue = 3/2;
        
        simpson_absError = abs(trueValue - simpsonValue);
        trapezoid_absError = abs(trueValue - trapezoidValue);
        
        disp(vpa(simpson_absError, 5));   % Format to 5 significant figures.
        disp(vpa(trapezoid_absError, 5)); % Format to 5 significant figures.
        
    case 4
        %% Exercise 4: Romberg Integration
        clc; clear; close all;

        % Function in question.
        f = @(x) sin(2*x) - 5*( (1./(x+1)) -1);
        true_value = integral(f, 0, 10);
        
        % 4a) Use trapezoid method and 2^5 partitions.
        R = zeros(6, 6);                      % Romberg extrapolation matrix
        relative_error = zeros(1, length(R)); % Relative error for trapezoid calculations.
        for k = 0:5
            n = 2^k;                  % Number of partitions/subintervals.
            p = n + 1;                % Number of points.
            x = linspace(0, 10, p);   % x coordinates.
            y = f(x);                 % y coordinates.
            dx = (x(p) - x(1))/(2*n); % Step size.
            
            R(k+1, 1) = (dx)*(y(1) + 2*sum(y(2:end-1)) + y(end));
            relative_error(k+1) = abs(true_value - R(k+1,1))/(true_value);
        end
        
        % 4b) Create a 5th order Romberg table for the function.
        for n = 2:6
            for k = 2:6
                if n>=k
                    R(n, k) = (4^(k-1) - 1)^(-1) *( (4^(k-1))*R(n, k-1) - R(n-1, k-1) );
                end
            end
        end

        % 4c) Print the estimated areas and relative errors from (4a) and
        % the romberg table from (4b).
        fprintf('True value of the integral: %0.4f', true_value);
        fprintf('\nEstimated area for 2^5 partitions: %0.4f', R(6));
        fprintf('\nRelative error for 2^5 partitions: %0.4f\n', relative_error(6));
        fprintf('The 5th order Romberg Extrapolation: %0.4f\n\n', R(end));
        fprintf('5th Order Romberg Extrapolation Table: \n\n');
        disp(R)
        
    case 5
        %% Exercise 5: 
        clc; clear; close all;

    case 6
        %% Exercise 6: 
        clc; clear; close all;
        
    otherwise
        error('Invalid Problem Number');
end