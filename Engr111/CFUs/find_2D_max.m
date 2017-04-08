function [ row, column ] = find_2D_max( matrix )
%FIND_2D_MAX finds the largest value and its index in the input
%matrix.

% Variables
largestElement = matrix(1,1);
row = 0;
column = 0;

% Check input
if ismatrix(matrix) == 0
    error('Please input a 2D array');
end

% Processing
for i = 1:size(matrix,1)
    for j = 1:size(matrix,2)
        if matrix(i,j) > largestElement
            largestElement = matrix(i,j);
            row = i;
            column = j;
        end
    end
end


end

