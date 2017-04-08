function [ ] = sort3( x,y,z )
%SORT3 takes three number inputs and outputs them in descending order.
%   SORT3 compares the three numbers to find out the order of them in
%   descending order.

xYLargest = 0;
max = 0;
mid = 0;
min = 0;

if x>y 
    xYLargest = x;
    mid = y;
else 
    xYLargest = y;
    mid = x;
end
    
if z > xYLargest
    max = z;
    min = mid;
    mid = xYLargest;
elseif z > x || z > y
        max = xYLargest;
        min = mid;
        mid = z;
else
        max = xYLargest;
        min = z;
end

fprintf('The numbers in descending order are: %0.1f, %0.1f, %0.1f\n', max, mid, min);

end

