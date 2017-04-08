function [ output_args ] = fizzbuzz( x, y, limit )
%FIZZBUZZ prints a list of numbers. 
%   FIZZBUZZ prints a list of numbers and replaces those divisible by x
%   with fizz, and those divisible by y with buzz.

for i = 1:limit 
    if mod(i, x) == 0 && mod(i,y) ~= 0
        fprintf('fizz ');
    elseif mod(i,y) == 0 && mod(i,x) ~=0
        fprintf('buzz ');
    elseif mod(i,x) == 0 && mod(i,y) == 0
        fprintf('fizzbuzz ');
    else
        fprintf('%d ', i);
    end
    
    if i == limit
        fprintf('\n');
    end
end

