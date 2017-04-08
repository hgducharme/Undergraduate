function [ semiFactorial ] = semifactorial( x )
%SEMIFACTORIAL Computes the semifactorial of a given number.

semiFactorial = 1;

% For loop for even x
if mod(x,2) == 0
    for i=2:2:x
        semiFactorial = semiFactorial*i;
    end
% For loop for odd x
else
    for i=1:2:x
        semiFactorial = semiFactorial*i;
    end
end

end

