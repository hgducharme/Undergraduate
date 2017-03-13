% OPTIMIZE_DEFLECTION Finds the optimal length of a wing that will give
% maximum deflection based on the following variables:
% f, distributed loading on the structure
% E, modulus of elasticity of the structure
% b, the width of wing
% t, the thickness of the wing
clc; clear; close;

% Constants and Variables
global f E b t maxDeflection

f = .01;           % lb/ft
E = 10*(10^6);     % psi
b = 7;             % ft
t = 10;            % in
minLength = 200;   % ft
maxLength = 300;   % ft
maxDeflection = 1; %
epsilon = .001;

fMinLength = Ralston(f, E, b, t, minLength, maxDeflection);
fMaxLength = Ralston(f, E, b, t, maxLength, maxDeflection);

midLength = (minLength + maxLength)/(2);
fmid = Ralston(midLength);

while abs(fmid) > eps
    midLength = (minLength + maxLength)/(2);
    fmid = Ralston(midLength);
    
    if sign(fmid) == sign(fMinLength);
        minLength = midLength;
        fMinLength = Ralston(minLength);
    else
        maxLength = midLength;
        fMaxLength = Ralston(maxLength);
    end
end