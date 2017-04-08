function [ lnX, k ] = mylog( x, tol )
%MYLOG computes the natural log of the given number within a specified
%range of error 'tol'.

% Check for nonsensical inputs.
if ~isnumeric(x) || ~isnumeric(tol)
    error('Both inputs need to be numeric.');
elseif (x <= 0) || (x > 2)
    error('This condition must be satisfied: 0 < x <= 2.');
end

% Variables
k = 1;
value = 10000;
lnX = 0;

% Processing
while value > tol 
    step = ((x-1)^k)/k;
    value = step;
    if mod(k, 2) == 0
        lnX = lnX - step;
    else
        lnX = lnX + step;
    end
    k = k + 1;
end



end

