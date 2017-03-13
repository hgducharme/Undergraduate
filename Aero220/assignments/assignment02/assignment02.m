%% Header

% -----------------------------------
%    HOMEWORK 2
%
%    Author:      Hunter Ducharme
%    Class:       AERO 220
%    Professor:   Dr. Raihan
%    Due date:    17 Feb 2017
% -----------------------------------

%%%% 
clear; close all; clc;

problem = 6;                     %#ok<NASGU> % Select a default number.
problem = input('Choose a problem (1-6): '); % Prompt the user for a number.

% Use a 'switch' statement to allow selection of different problems
switch(problem)
    
    case 1
        %% Exercise 1: Error Conceptual Questions.
        % 
        % *Truncation error:* A truncation error occurs when using an
        % approximation in place of an exact mathematical procedure (e.g.
        % Taylor Series). The size of the truncation error is proportional
        % to the number of iterations.
        %
        % *Round-off error:* A round-off error is the difference between an
        % approximation of a number and the actual exact value of that
        % number. Round off errors dominate during large computations (i.e.
        % a lot of computations) and adding a large number to a small
        % number.
    
    case 2
        %% Exercise 2: Observing errors using chop().
        clc; clear; close;
        
        % 2.1 Evaluate the cubic polynomial at x = 1.32.
        a = 1.32;

        % f(1.32) with regular machine error.
        machinePrecision = (3.15*a^2) - (2.11*a) + 4;
        % f(1.32) using 3 sig figs at each arithmetic operation.
        threeSigFigs = chop((3.15)*(a^2), 3) - chop(2.11*a, 3) + 4;
        % Calculate errors for 2.1.
        absoluteError = abs(machinePrecision - threeSigFigs);
        relativeError = absoluteError/abs(machinePrecision);
        
        % 2.2 Repeat 2.1 but with nested multiplication.
        i = chop(3.15*a, 3);
        j = chop(a-2.11, 3);
        k = chop(j*a, 3);
        l = chop(k+4.01, 3);
        % Calculate errors for 2.2.
        absoluteError2 = abs(machinePrecision - l);
        relativeError2 = absoluteError2/abs(machinePrecision);
        
    case 3
        %% Exercise 3: Approximate e^(-4) using taylor series.
        clc; clear; close;
        
        precision = 4;             % The amount of digits to keep.
        iterations = 7;            % The number of iterations to use.
        trueValue = 1.832*10^(-2); % True value of e^(-4).
        
        % 3a.
        approximationA = 0; % The approximation of part 3.a.
        for i = 0:iterations
            approximationA = approximationA + ((-1)^i)*(4^i)/(factorial(i));
        end
        
        % 3b.
        approximation = 0;
        for i = 0:iterations
            approximation = (approximation) + (4^i)/(factorial(i));
        end
        
        % The approximation of part 3b.
        approximationB = (1/approximation);
        
        % Compute errors for both cases. 
        absoluteErrorA = abs(trueValue - approximationA);
        absoluteErrorB = abs(trueValue - approximationB);
        relativeErrorA = absoluteErrorA/abs(trueValue);
        relativeErrorB = absoluteErrorB/abs(trueValue);
        
        fprintf('Part 3b is more accurate because it avoids the summation over large terms with opposite terms.');
        
    case 4
        %% Exercise 4: Find real root of f(x) = ln(x).
        clc; clear; close;
        
        % 4a. Use bisection method.
        f = @(x) log(x); % Function to find root of.
        error = 0.1;     % Error tolerance.
        a = 0.5;         % Lower bound.
        b = 5;           % Upper bound.
        c = b;           % Midpoint of the interval.
        
        while f(c) > error
            % Calculate the midpoint.
            c = (a+b)/2;
            
            % If c is the root, break the loop.
            if f(c) == 0
                break;
            % Elseif f(a) & f(c) have opposite signs, move the upper bound
            % to c.
            elseif (f(a)*f(c) < 0)
                b = c;
            % Else, move the lower bound to c.
            else 
                a = c;
            end
        end
        
        % 4b. Use secant method.
        xNMinusOne = 0.5; % Lower bound.
        xN = 5;           % Upper bound.
        % Intersection point.
        xNPlusOne = (xNMinusOne) - (f(xNMinusOne)*(xN - xNMinusOne)/(f(xN) - f(xNMinusOne)));
        
        while abs(f(xNPlusOne)) > error 
            % Calculate intersection point.
            xNPlusOne = (xNMinusOne) - (f(xNMinusOne)*(xN - xNMinusOne)/(f(xN) - f(xNMinusOne)));

            % Update the x values.
            xNMinusOne = xN;
            xN = xNPlusOne;
        end
        
    case 5
        %% Exercise 5: Determing the value of k that satisfies the equation.
        clc; clear; close;
        
        f = @(k,M) 1 + (k-1)*((1.3^2)/2)^(k/(k-1)); % Function in question.
        M = 0.5;  % Mach number.
        p0 = 415; % kPa
        p1 = 350; % kPa
        p = p0/p1;
        
        range = -50:50;
        plot(range, f(range, M));
        title('f(k) vs. k');
        xlabel('k Value');
        ylabel('f(k)');
        
        a = -50;         % Lower bound.
        b = 50;          % Upper bound.
        c = b;           % Regula-falsi point.
        n = 1;           % Iteration counter.
        error = 10^(-5); % Error tolerance.

        % Look for root until error tolerance is met.
        while abs(f(c)) > error
            % Calculate the regula-falsi point.
            c = a - f(a)*(b-a)/(f(b)-f(a));
            % If a and c give the same sign for y, then move a up to c.
            if sign(f(c)) == sign(f(a))
                a = c;     
            % Else, move b down to c.
            else
                b = c;
            end
        end

    case 6
        %% Exercise 6: Use taylor series to simplify equation.
        %
        % Done on piece of paper.
    otherwise
        error('Invalid Problem Number'); %#ok<NOEFF>
end