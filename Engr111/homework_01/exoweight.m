%EXOWEIGHT computes the weight of a person on the moon, Neptune, Mars, and
%Pluto.
%   EXOWEIGHT defines the masses and radii for each planetary body: the
%   moon, Neptune, Mars, and Pluto. Then, it takes an input of the weight
%   of a person on earth in order to calculate mass, which can then be used
%   in the compute_gravitational_force script to calculate the weight of
%   that person on the given planetary body.

% Constants
MOON_MASS = 7.34767309e22; % Kilograms
NEPTUNE_MASS = 1.024e26;   % Kilograms
MARS_MASS = 6.39e23;       % Kilograms
PLUTO_MASS = 1.309e22;     % Kilograms

MOON_RADIUS = 1.7374e6;    % Meters
NEPTUNE_RADIUS = 24.622e6; % Meters
MARS_RADIUS = 3.39e6;      % Meters
PLUTO_RADIUS = 1.187e6;    % Meters

POUND = .454; % Kilograms
KILOGRAM = 9.81; % Newtons on earth
WEIGHT_TWO_POUNDS = input('Please enter your weight in pounds: ');
% kg = (Wlb / 32ft/s^2)*(1kg / .454lb)
MASS_TWO = (WEIGHT_TWO_POUNDS * POUND); % Kilograms

% Processing for the moon
MASS_ONE = MOON_MASS;
DISTANCE = MOON_RADIUS;
fprintf('\nCalculations for the moon:\n');
compute_gravitational_force;
personWeightMoonPounds = gravitationalForceLbs;
fprintf('You would weigh %.2f lbs on the moon.\n', personWeightMoonPounds);

% Processing for Neptune
MASS_ONE = NEPTUNE_MASS;
DISTANCE = NEPTUNE_RADIUS;
fprintf('\nCalculations for Neptune:\n');
compute_gravitational_force;
personWeightNeptunePounds = gravitationalForceLbs;
fprintf('You would weigh %.2f lbs on Neptune.\n', personWeightNeptunePounds);

% Processing for Mars
MASS_ONE = MARS_MASS;
DISTANCE = MARS_RADIUS;
fprintf('\nCalculations for Mars:\n');
compute_gravitational_force;
personWeightMarsPounds = gravitationalForceLbs;
fprintf('You would weight %.2f lbs on Mars.\n', personWeightMarsPounds);

% Processing for Pluto
MASS_ONE = PLUTO_MASS;
DISTANCE = PLUTO_RADIUS;
fprintf('\nCalculations for Pluto:\n');
compute_gravitational_force;
personWeightPlutoPounds = gravitationalForceLbs;
fprintf('You would weight %.2f lbs on Pluto.\n', personWeightPlutoPounds);
