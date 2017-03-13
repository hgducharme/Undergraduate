%% 1. Calculate absolute, absolute relative, and percent relative error.
clc; clear; close;
spar_measured = 0.39;    % m
spar_real = 0.40;        % m
length_measured = 39.99; % m
length_real = 40.00;     % m

absoluteErrorSpar = abs(spar_real - spar_measured);
absoluteErrorLength = abs(length_real - length_measured);

relativeErrorSpar = (1/spar_real)*(absoluteErrorSpar);
relativeErrorLength = (1/length_real)*(absoluteErrorLength);

percentErrorSpar = relativeErrorSpar * 100;
percentErrorLength = relativeErrorLength * 100;

%% 2. Use macluarian series to approximate e^(0.5),
clc; clear; close;

% 2a. Calculate the relative approximate error and store each iteration in
% a matrix.
% 2b. Calculate the true relative error and store each iteration in
% a matrix.

x = 0.5;                                % Number to be approximated, exp(0.5).
errorTolerance = 10^(-5);               % Error tolerance.
approximation = [1];               % Matrix containing approximation values for each iteration.
relativeError = [2*errorTolerance];     % Matrix containing relative error values for each iteration.
trueRelativeError = [2*errorTolerance]; % Matrix containing absolute error values for each iteration.
n = 2;                                  % Iteration number.

while relativeError > errorTolerance
    
   % Macularian series formula for exp(x).
   approximation(n) = approximation(n-1) + (x^(n-1))/(factorial(n-1));
   
   % Calculate relative error and store it in the vector relativeError.
   relativeError(n) = (1/approximation(n-1))*abs(approximation(n-1) - approximation(n));
   
   % Calculate true relative error and store it in the vector trueRelativeError.
   trueRelativeError(n) = exp(-0.5)*abs(exp(0.5) - approximation(n));
   
   % Update iteration value.
   n = n + 1;
end

%% 3. For a random 5x6 matrix A, 
clc; clear; close;

A = rand(5, 6);

% 3a. Create a new matrix B that replaces all the elements in every odd row of A with even numbers starting with 2.
[rows, columns] = size(A);
B = A;

for i = 1:2:size(A, 1)
    evenValue = 2;

    for j = 1:size(A,2)
        B(i, j) = evenValue;
        evenValue = evenValue + 2;
   end
end

% 3b. Create a new matrix C that is the transpose of B by writing a loop.
C = B;
for i = 1:size(B, 1)
    for j = 1:size(B,2)
        C(j,i) = B(i,j);
    end
end

% 3c. Create a matrix D that is the product of B and C.
% ANSWER: You can't do this because the rows of C don't match the columns
% of B.

% 3d. Create a matrix E that is the transpose of D.
% ANSWER: E doesn't exist because D doesn't exist.