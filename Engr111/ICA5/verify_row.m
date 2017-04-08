function [ trueOrFalse ] = verify_row( A, n )
%ARRAY_CONTAINS_1_TO_N checks to see if a 1 dimensional array contain the
%integer numbers from 1 to n each exactly one.

trueOrFalse = 'Something went wrong.';

% Check to see if array is 1 dimensional & has length of n
if size(A,1) ~= 1 || length(A) ~= n
    trueOrFalse = 0;
    return;
end

% Create array to check count of each number in input array
C = zeros(1, n);

for i=1:1:length(A)
    element = A(i);
    if element < 1
        trueOrFalse = 0;
        return;
    elseif element > n
        trueOrFalse = 0;
        return;
    else
        C(element) = C(element) + 1;
        % If the element has appeared more than once
        if C(element) > 1 
            trueOrFalse = 0;
            return;
        else
            trueOrFalse = 1;
        end
    end
end

end

