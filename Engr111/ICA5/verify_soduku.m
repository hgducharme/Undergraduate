function [ logicValue ] = verify_soduku( S )
%VERIFY_SODUKU Checks whether a 9x9 matrix contains a valid soduku solution.

logicValue = 'Something went wrong.';

% Iterate over each row of the input matrix
for i = 1:1:size(S,1)
    row = S(i, :);
    % Check if row contains numbers 1 to 9 exactly once
    if verify_row(row, 9) == 0
        logicValue = 0;
        return;
    else
        logicValue = 1;
    end
end

% Iterate over each column
for i = 1:1:size(S,2)
    column = S(:, i);
    % Check if column transpose contains numbers 1 to 9 exactly once
    if verify_row(column', 9) == 0
        logicValue = 0;
        return;
    else
        logicValue = 1;
    end
end
disp(S);
% Check boxes by the column
for i=1:3:9
    % Extract submatrices
    topBox = S([1,2,3], [i:i+2]);
    middleBox = S([4,5,6], [i:i+2]);
    bottomBox = S([7,8,9], [i:i+2]);
    
    % Convert each submatrix to row vector
    topBoxVector = reshape(topBox, [1,9]);
    middleBoxVector = reshape(middleBox, [1,9]);
    bottomBoxVector = reshape(bottomBox, [1,9]);
    
    % Verify all row vectors contain each number 1-9 exactly once
    topBoxCheck = verify_row(topBoxVector, 9);
    middleBoxCheck = verify_row(middleBoxVector, 9);
    bottomBoxCheck = verify_row(bottomBoxVector, 9);
    
    % If any row vectors dont contain each number 1-9 exactly once, return
    % false
    if topBoxCheck == 0 || middleBoxCheck == 0 || bottomBoxCheck == 0
        logicalValue = 0;
        return;
    else
        logicalValue = 1;
    end
end
    
end