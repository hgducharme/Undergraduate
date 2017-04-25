% -----------------------------------
%    HOMEWORK 06
%
%    Author:      Hunter Ducharme
%    Class:       AERO 220
%    Professor:   Dr. Raihan
%    Due date:    26 April 2017
% -----------------------------------
%%%% 

clear; close all; clc;

problem = 6;                     %#ok<NASGU> % Select a default number.
problem = input('Choose a problem (1-6): '); % Prompt the user for a number.

% Use a 'switch' statement to allow selection of different problems.
switch(problem)
    
    case 1
        %% Exercise 1: Monomial Least-squares Approximation
        clc; clear; close all;
       
        % Function to find least-squares solution for.
        y = @(x) sin(x).*exp(-x.^2);
        
        % Function to estimate the data points.
        yApproximate = @(x,a,b) a.*(x.^b);
        
        % Consider 3 different cases to find a least squares solution to. 
        % Each case is formatted as [ [dataPoints, monomialDegree], ... ]
        % pairs.
        nd_pairs = [[5 3]; [10 3]; [10 5]];
        numberOfCases = size(nd_pairs,1);
        
        % Bounds for the interval.
        lower_bound = -1;
        upper_bound = 1;
        
        % Perform least squares approximation for each case.
        for i = 1:1:numberOfCases
            numberOfPoints = nd_pairs(i, 1); % Number of data points for the interval.
            degree = nd_pairs(i, 2);         % Degree of the monomial.
            
            % Generate the x and y values.
            stepSize = (upper_bound-lower_bound)/(numberOfPoints-1); 
            xDataPoints = lower_bound:stepSize:upper_bound;
            yDataPoints = y(xDataPoints);
            
            % Setup the least-square system and solve it.
            coeffMatrix = (xDataPoints.^degree).';
            zMatrix = yDataPoints.';
            solution = (coeffMatrix.' * coeffMatrix)*coeffMatrix.' * zMatrix;
           
            % Get the fitting function now that the unkonwn has be computed.
            fittingFunction = yApproximate(xDataPoints, solution, degree);
            
            % Plot the data points, and the calculated function for each case.
            figure()
            plot(xDataPoints, yDataPoints, '.k', 'displayName', 'Data points', ...
                'lineWidth', 1, ...
                'MarkerSize', 13);
            hold on;
            plot(xDataPoints, fittingFunction, '-.k', ...
                'DisplayName', 'Fitting function', ...
                'LineWidth', 0.8);
            hold off;
            
            % Add titles and labels to the plot.
            title(sprintf('Least Squares Approximation for n,d Pair: [%d, %d]', length(xDataPoints), degree));
            xlabel('x');
            ylabel('y');
            lgd = legend('show', 'location', 'best');
            title(lgd, sprintf('n,d Pair: [%d, %d]', length(xDataPoints), degree));
        end
        
        
    case 2
        %% Exercise 2: Harmonic Least-squares Approximation
        clc; clear; close all;
        
        % Function to find least-squares solution for.
        y = @(x) sin(x).*exp(-x.^2);
        
        % Function to estimate the data points.
        yApproximate = @(x, A, phi) A.*sin(2.*x + phi);
        
        % Consider 2 different cases to do least squares approximation.
        % 1st case: number of x values = 5.
        % 2nd case: number of x values = 10.
        cases = [5, 10];
        numberOfCases = length(cases);
        
        % Bounds for the interval.
        lower_bound = -1;
        upper_bound = 1;
        
        % Perform least squares approximation for each case.
        for i = 1:1:numberOfCases
            numberOfPoints = cases(1, i); % Number of data points for the interval.
            omega = 2;
            
            % Generate the x and y values.
            stepSize = (upper_bound-lower_bound)/(numberOfPoints-1); 
            xDataPoints = lower_bound:stepSize:upper_bound;
            yDataPoints = y(xDataPoints);
            
            % Setup the least-square system and solve it.
            % Create the Hankel matrix.
            firstElement = sum(sin(omega*xDataPoints).^2);
            secondElement = sum(cos(omega*xDataPoints).*sin(omega*xDataPoints));
            thirdElement = sum(cos(omega*xDataPoints).*sin(omega*xDataPoints));
            fourthElement = sum(cos(omega*xDataPoints).^2);
            hankelMatrix = [ firstElement, secondElement; ...
                thirdElement, fourthElement];
                         
            % Create the matrix that the rows are equal to.
            yMatrix = [sum(yDataPoints.*sin(omega.*xDataPoints)); ...
                sum(yDataPoints.*cos(omega.*xDataPoints))];
            
            % Find solutions.
            a = hankelMatrix \ yMatrix;
            alpha = a(1);
            beta = a(2);
            
            % Compute amplitude and phase angle.
            amplitude = sqrt(alpha^2 + beta^2);
            phase = asin(beta/amplitude);
            
            % Get the fitting function now that the unkonwn has be computed.
            fittingFunction = yApproximate(xDataPoints, amplitude, phase);
            
            % Plot the data points, and the calculated function for each case.
            figure()
            plot(xDataPoints, yDataPoints, '.k', 'displayName', 'Data points', ...
                'lineWidth', 1, ...
                'MarkerSize', 13);
            hold on;
            plot(xDataPoints, fittingFunction, '-.k', ...
                'DisplayName', 'Fitting function', ...
                'LineWidth', 0.8);
            hold off;
            
            % Add titles and labels to the plot.
            title(sprintf('Least Squares Approximation for n = %d', length(xDataPoints)));
            xlabel('x');
            ylabel('y');
            lgd = legend('show', 'location', 'best');
            title(lgd, sprintf('n = %d', length(xDataPoints)));
        end
        
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