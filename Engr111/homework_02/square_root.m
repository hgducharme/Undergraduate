function [ ] = square_root( a,b,c )
%SQUARE_ROOT computes the roots of a quadratic equation.
%   SQUARE_ROOT takes the coefficient values of a quadratic equation and
%   solves for the roots of said equation.

if ~isscalar(a) || ~isscalar(b) || ~isscalar(c)
    error('One of the coefficients is not a scalar.');
end

% Solve for the two roots
x1 = (1/(2*a))*(-b + sqrt( (b^2) - 4*a*c ));
x2 = (1/(2*a))*(-b - sqrt( (b^2) - 4*a*c ));

% Let x1 be the smaller of the two roots
if x1 > x2
    x1 = x2;
    x2 = x1;
end

if isinf(x1) == 1 && isnan(x2) == 1
    x1 = -c/b;
    x2 = NaN;
    warning('Coefficient a is 0.');
elseif isreal(x1) == 0 || isreal(x2) == 0
    warning('Delta = (b^2)-4ac is negative.');
elseif (b^2 - 4*a*c) == 0
    x1, x2 = -b/(2*a); %#ok<NOPRT>
end

fprintf('x1 = %d\nx2 = %d \n', x1, x2);

end