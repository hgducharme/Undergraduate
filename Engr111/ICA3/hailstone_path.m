function [ ] = hailstone_path( n )
%HAILSTONE_PATH Computes the hailstone path length of a positive integer.
% h(n) = n/2, where n is even
% h(n) = 3n+1, where n is odd

currentNumber = n;
hailstonePathLength = 1;
largestNumber = 0;
fprintf('%d -> ', n)

while currentNumber > 1
    if mod(currentNumber, 2) == 0
        currentNumber = (currentNumber/2);
        hailstonePathLength = hailstonePathLength + 1;
        if currentNumber == 1
            fprintf('%d', currentNumber);
        else
            fprintf('%d -> ', currentNumber);
        end
        if currentNumber > largestNumber
            largestNumber = currentNumber;
        end
    elseif mod(currentNumber, 2) ~= 0
       currentNumber = (3*currentNumber + 1);
       hailstonePathLength = hailstonePathLength + 1;
       fprintf('%d -> ', currentNumber);
       if currentNumber > largestNumber
            largestNumber = currentNumber;
       end
    end
end
fprintf('\nThe Hailstone path length for %d is %d.\n', n, hailstonePathLength);
fprintf('The largest number in this sequence is %d.\n', largestNumber);
end

