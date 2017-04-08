% By submitting this assignment, I agree to the following:
% “Aggies do not lie, cheat, or steal, or tolerate those who do”
% “I have not given or received any unauthorized aid on this assignment”
%
% Name: Hunter Ducharme
% Section: 533
% Assignment: Square root calculator
% Date: 15 November 2016

% Constants and Variables
S = input('Please enter a number you would like the square root of: ');
xPrevious = 0;
xCurrent = 0;
DX = xCurrent - xPrevious;

% Processing
while abs(DX) < 10^(-6)
    make guesses
end