function [ logicValue ] = verify_magic( square_matrix )
%VERIFY_MAGIC verifies that the given square_matrix contains the magic
%property.
%   VERIFY_MAGIC returns 1 if the given square matrix contains the magic
%   proprety, and returns 0 if it does not.

%% Variables
[rows, columns] = size(square_matrix); % dimensions of input matrix
n = rows;                              % matrix square size
row_column_sums = zeros(2, columns);   % [sum of each row; sum of each column]
diagonal_sums = zeros(1, 2);           % [top left to bottom right diagonal sum, top right to bottom left diagonal sum]
logicValue = 'Something went wrong.';  % 1 = true, 0 = false

%% Check to see if input is a square matrix
if rows ~= columns
    error('Please input a square matrix.');
end

%% Processing
% Iterate over each row of the square matrix to check summation property
for i = 1:1:rows
    % Iterate over each column of the square matrix
    for j = 1:1:columns
        % For row i, add each element in the row and keep track
        row_column_sums(1,i) = row_column_sums(1,i) + square_matrix(i,j);
        % For column j, add each element in the column and keep track
        row_column_sums(2,j) = row_column_sums(2,j) + square_matrix(i,j);
        
        % if current iteration is on matrix diagonal from top left to bottom
        % right, add the element to other elements on diagonal
        if i == j
            diagonal_sums(1,1) = diagonal_sums(1,1) + square_matrix(i,j);
        end
        
        % if current iteration is on matrix diagonal from top right to bottom
        % left, add the element to other elements on diagonal
        if j == n - i + 1
            diagonal_sums(1,2) = diagonal_sums(1,2) + square_matrix(i,j);
        end
    end
end

%% Iterate over summations to see if they all match
previous_value = 0; % previous value of the iteration
flag = false;       % if true, break out of entire nested loop structure
% Iterate over each row of row_column_sums
for i = 1:size(row_column_sums,1)
    
    % Iterate over each column of row_column_sums
    for j = 1:size(row_column_sums,2)
        % if iteration is on first element, set previous_value to first
        % element
        if i==1 && j==1
            previous_value = row_column_sums(i,j);
        end
        
        % Check if current summation is equal to previous summation
        if row_column_sums ~= previous_value
            logicValue = 0;
            flag = true;
            disp('not magic');
            break
        else
            logicValue = 1;
        end
    end
    
    % Break from this for loop
    if flag == true
        break
    end
end

% Check to see if diagonal sums both match
if diagonal_sums(1,1) ~= diagonal_sums(1,2)
    logicValue = 0;
else
    logicValue = 1;
end

end