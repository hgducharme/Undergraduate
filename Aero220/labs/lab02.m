%{

AERO 220 Spring 2017
Instructor: Dilshad Raihan, dilshadraihan@gmail.com 
TA: Ralston Fernandes, ralston92@tamu.edu


LAB 2: Intro to MATLAB

Split each part into separate chunks using '%%' comments and run each chunk
separatly using "Ctlr+Enter" 

1. Solve the following system of linear equations
     2*x + y + z = 2
     - x + y - z = 3
   x + 2*y + 3*z = -10

   a. by calculating the inverse 
   b. by using the backslash operator "\"

2. Use a loop to sum numbers over range [-10, 105]. Check your solution
using the inbuilt MATLAB function "sum"
    a. all the integers in the range
    b. step size of 5
    c. split the interval into 100 digits and sum those

3. go to the Mathworks tutorial website (do a web search for "Matlab plot" 
to get there)on the 'plot' function and code up the
first example plot

4. modify the plot to add extra lines.
    a. add another sine curve phase shifted by 1, make it a red dashed line
    b. add another green sine curve with half the amplitude and period of
    the original sine curve. Plot it as a series of green stars
    
%}


%% 1. Solve the system of linear equations
clc; clear; close all;

A = [2,1,1; -1,1,-1; 1,2,3];
b = [2;3;-10];

% 1a. Solve A using inverse.
AInverse = inv(A);
solutionInverse = AInverse * b; %#ok<MINV>
disp('1a. Using inverse:');
disp(solutionInverse);

% 1b. Solve A using the backslash operator "\".
solutionBackslash = A\b;
disp('1b. Using backslash:');
disp(solutionBackslash);

%% 2. Use a loop to sum numbers over range [-10, 105].
clc; clear; close all;

range = -10:105;

% 2a. Sum all integers in the range.
sumAll = 0;
for i = -10:105
    sumAll = sumAll + i;
end
fprintf('2a. Using for loop: %i', sumAll);
fprintf('\n2a. Using sum function: %i', sum(range));

% 2b. Step size of 5.
sumStepSize5 = 0;
for i = 1:5:length(range)
    sumStepSize5 = sumStepSize5 + range(i);
end
fprintf('\n2b. Using for loop: %i', sumStepSize5);
fprintf('\n2b. Using sum function: %i', sum(-10:5:105));

% 2c. Split the interval into 100 digits and sum those.


%% 3. 'plot' the first example.
clc; clear; close all;

A = [2,1,1; -1,1,-1; 1,2,3];
b = [2;3;-10];

figure
plot(A);

%% 4. Modify the plot to add extra lines.
clc; clear; close all;

A = [2,1,1; -1,1,-1; 1,2,3];
x = 0:pi/100:2*pi;

% 4a. Add another sine curve phase shifted by 1, make it a red dashed line.
sineCurve = sin(x+1);
figure
hold on; grid on;
plot(x, sineCurve, 'r--');

% 4b. Add another green sine curve with half the amplitude and period of.
sineCurve2 = 0.5*sin(0.5*x);
plot(x, sineCurve2);

% 4c. Plot the original sine curve as a series of green stars.
sineCurveGreenStars = sin(x+1);
plot(x, sineCurveGreenStars, 'g*');
