function [ median ] = median( A )
%MEDIAN computes the median of the array A.

median = 0;

%%%% Seletion sort algorithim
n = length(A);

for j = 1:(n - 1)
    % Find jth smallest element
    imin = j;
    for i = (j + 1):n
        if (A(i) < A(imin))
            imin = i;
        end
    end
    
    % Put jth smallest element in place
    if (imin ~= j)
        A = swap(A,imin,j);
    end
end


function A = swap(A,i,j)
% Swap A(i) and A(j)
% Note: In practice, A Ahould be passed by reference

val = A(i);
A(i) = A(j);
A(j) = val;
end
%%%% END Selection sort algorithim

if mod(n,2) ~= 0
    median = A(n/2+1);
    disp(median);
else
    median = (A(n)+A(n/2+1))/2;
    disp(median);
end

end