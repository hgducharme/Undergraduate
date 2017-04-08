%COMPUTE_GRAVITATIONAL_FORCE computes the weight of a person on any given
%planet.
%   COMPUTE_GRAVITATIONAL_FORCE uses the mass of a planetary body MASS_ONE, the mass of a person MASS_TWO, and the
%   distance to the CG of the planet DISTANCE to compute the weight of that
%   person on said planetary body.

% Constants
GRAVITATIONAL_CONSTANT = 6.674*(10^-11);
POUND = 4.4537; % Newtons

% Processing
force = (DISTANCE^(-2))*(GRAVITATIONAL_CONSTANT)*(MASS_ONE)*(MASS_TWO);
gravitationalForceNewtons = force;
gravitationalForceLbs = (force)*(1/4.4537);

% Output
fprintf('The gravitational force in newtons is: %0.3f N\n', gravitationalForceNewtons);
fprintf('The gravitational force in pounds is: %0.3f lbs\n', gravitationalForceLbs);