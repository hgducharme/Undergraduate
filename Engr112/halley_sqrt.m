function [ guess ] = halley_sqrt( A, epsilon )
%HALLEY_SQRT Computes the squareroot of a number.

% Variables
guess = 1;
intermediate_step = 0;
criterion = abs(guess - intermediate_step);

%% DOESNT WORK
while criterion <= epsilon
    approximation = (1/A)*(guess^2);
    guess = (guess/8)*(15 - intermediate_step*(10-3*approximation));
end