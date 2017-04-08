function [ sum ] = my_sum( numbersArray )

sum = 0;
for i = 1:length(numbersArray)
    sum = sum + numbersArray(i);
end