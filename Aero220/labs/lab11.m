%% 1. Approximate derivative of sin(x)
clc; clear; close;

f = @(x) sin(x); % Define function.
x0 = (pi/4);     % Point to evaluate function at.
h = (pi/12);     %Step size.

% 3-point backward difference
M_bckwd = [ -h, (h^2)/factorial(2);
            -2*h, 4*(h^2/factorial(2))];
b_bckwd = [f(x0-h)-f(x0);
           f(x0-(2*h))-f(x0)];

der_bckwd = M_bckwd\b_bckwd;
absErrorBckwd = abs(der_bckwd - cos(x0))/abs(cos(x0));

% 3-point forward difference
M_fwd = [h, h^2/factorial(2); 
         2*h, 4*(h^2/factorial(2))];
b_fwd = [f(x0+h) - f(x0); 
         f(x0+(2*h)) - f(x0)];

der_fwd = M_fwd\b_fwd;
absErrorFwd = abs(der_fwd - cos(x0))/abs(cos(x0));


% 3-point central difference
M_cntrl = [h, h^2/(factorial(2));
           -h, h^2/(factorial(2))];
b_cntrl = [f(x0+h) - f(x0);
           f(x0-h) - f(x0)];

der_cntrl = M_cntrl\b_cntrl;
absErrorCntrl = abs(der_cntrl - cos(x0))/(abs(cos(x0)));

%% 2. Newton's Law of Cooling
clc; clear; close;

Ta = 21;                               % deg C, ambient temperature.
T = [80, 44.5, 30, 24.1, 21.7, 20.7];  % deg C, temperature of the ball.
t = [0, 5, 10, 15, 20, 25];            % minutes, the times corresponding to the values of T.
h = t(2) - t(1);                       % Step size.

% 3 point forward difference for the first point.
DTdt = zeros(length(T), 1);
DTdt(1) = (-3*T(1) + 4*T(2) - T(3))/(2*h);

% 3 point central difference for the interior points
for i = 2:(length(T) - 1)
    DTdt(i) = (T(i+1)-T(i-1))/(2*h);
end

% 3 point backward difference for the last point
DTdt(end) = (3*T(end) + T(end-2) +4*T(end-1))/(2*h);

% 2.2 Use 'polyfit' to find the unknown parameter k.
fit = polyfit((T-Ta)', DTdt, 1);
k = -fit(1); % Unknown parameter.

% 2.3 Plot t vs. dT/dt and t vs. (T-Ta)
plot(t, DTdt, '-*b');
hold on; grid on;
plot(t, -k*(T-Ta), '-r*');