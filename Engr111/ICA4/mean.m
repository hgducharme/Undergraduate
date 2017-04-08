function [ mean ] = mean( A )
%MEAN computes the mean of array A

sum = 0;
for i = 1:1:length(A)
    sum = sum + A(i);
end
mean = sum / length(A);

