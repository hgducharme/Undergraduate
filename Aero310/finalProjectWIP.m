clc; clear; close;
%% Known quantities

% Variables related to the entire structure as a whole
syms L m g r k lNaught theta(t) thetaVar thetaDot thetaDoubleDot thetaInitial omegaAG

% Unknown reaction forces
syms Ax Ay Bx By Cx Cy Dx Dy Nx Ny springForceVertical springForceHorizontal

% Constants and reference frames
gravity = [0; -m*g;     0];                    % A or G reference frame
omega =   [0; -omegaAG; 0];                    % A or G reference frame

% Angular momentum of frame B relative to frame G
omegaBG = [-omegaAG*cos(theta(t)/2);...
           omegaAG*sin(theta(t)/2) ;...
           -(1/2)*diff(theta(t),t) ];   % B reference frame
       
% Angular momentum of frame C relative to frame G
omegaCG = [-omegaAG*cos(theta(t)/2);...
           omegaAG*sin(theta(t)/2) ;...
           (1/2)*diff(theta(t),t)  ];   % C reference frame

% Multiply this matrix to a vector in the B frame to transform to A frame
% [a1; a2; a3] = (...)(b1; b2; b3]
BFrameToAFrame = [-sin(theta(t)/2), -cos(theta(t)/2), 0;...
                  cos(theta(t)/2),  -sin(theta(t)/2), 0;...
                  0,                0,                1]; % B reference frame

% Multiply this matrix to a vector in the C frame to transform to A frame
% [a1; a2; a3] = (...)(c1; c2; c3]
CFrameToAFrame = [sin(theta(t)/2), cos(theta(t)/2),  0;...
                  cos(theta(t)/2), -sin(theta(t)/2), 0;...
                  0,               0,                1]; % C reference frame

% Moment of inertia for a cylindrical bar relative to its principal-axis
% coordinate system
cylindricalBarMOI = [(m/2)*r^2           ;...
                     (m/12)*(3*r^2 + L^2);...
                     (m/12)*(3*r^2 + L^2)];

% Position vectors
r1 = (L/2)*[-sin(theta(t)/2); cos(theta(t)/2); 0];        % A reference frame
r2 = (L/2)*[ sin(theta(t)/2); cos(theta(t)/2); 0];        % A reference frame
r3 = 2*r1 + (L/2)*[ sin(theta(t)/2); cos(theta(t)/2); 0]; % A reference frame
r4 = 2*r2 + (L/2)*[-sin(theta(t)/2); cos(theta(t)/2); 0]; % A reference frame
position = [r1; r2; r3; r4];

%% Velocity vectors

localVelocity = diff(position, t);                   % Velocity relative to the spinning reference frame
velocityTransport = sym(zeros(length(position), 1)); % Velocity transport theorem

% Iterate from 1 to 4, but there is 12 position rows.
% We need to map the natural #s to the set S =
% {(1,2,3),(4,5,6),...(a,b,c)}
% Recursive formula: (a,b,c) = (n + 2*(n-1), a+1, a+2), for natural number
% n
for i = 1:(length(position)/3)
    lowerBound = 3*i - 2;
    upperBound = lowerBound + 2;
    
    velocityTransport(lowerBound:upperBound) = cross(omega, position(lowerBound:upperBound));
end

% Velocities relative to inertial reference frame, defined in A reference
% frame
absoluteVelocity = localVelocity + velocityTransport;

%% Acceleration vectors
localAcceleration = diff(localVelocity, t);                      % Accelerations relative to the spinning reference frames
accelerationTransport = sym(zeros(length(absoluteVelocity), 1)); % Acceleration transport theorem

for i = 1:(length(absoluteVelocity)/3)
    lowerBound = 3*i - 2;
    upperBound = lowerBound + 2;
    
    accelerationTransport(lowerBound:upperBound) = cross(omega, absoluteVelocity(lowerBound:upperBound));
end

% Accelerations relative to inertial reference frame, defined in A reference
% frame
absoluteAcceleration = localAcceleration + accelerationTransport;

%% Euler's laws for rod 1

% Unknown forces acting on rod 1:
% Ax Ay Bx By Nx Ny

% Rod 1 constants
positionARelCMRod1 = [-L/2; 0; 0];                           % B reference frame
positionBRelCMRod1 = [L/2; 0; 0];                            % B reference frame
netForceARod1 = [Ax + Nx; springForceVertical - Ay - Ny; 0]; % A reference frame
netForceBRod1 = [springForceHorizontal + Bx; -By; 0];        % A reference frame

% Euler's 1st law on rod's CM 
netForceRod1 = netForceARod1 + netForceBRod1 + gravity;        % A reference frame
euler1stLawRod1 = netForceRod1 == m*absoluteAcceleration(1:3); % DE's of motion

% Euler's 2nd law on rod's CM 
netMomentRod1 = cross(BFrameToAFrame*positionARelCMRod1, netForceARod1) + cross(BFrameToAFrame*positionBRelCMRod1, netForceBRod1); % A reference frame
angularMomentumRod1 = omegaBG.*cylindricalBarMOI;                                                                                  % B reference frame
angularMomentumRod1Prime = diff(angularMomentumRod1, t) + BFrameToAFrame*cross(omegaBG, angularMomentumRod1);                      % A reference frame
euler2ndLawRod1 = netMomentRod1 == angularMomentumRod1Prime;

%% Euler's laws for rod 2

% Unknown forces acting on rod 2:
% Ax Ay Dx Dy

% Rod 2 constants
positionARelCMRod2 = [-L/2; 0; 0]; % C reference frame
positionDRelCMRod2 = [L/2; 0; 0];  % C reference frame
netForceARod2 = [-Ax; Ay; 0];      % A reference frame
netForceDRod2 = [Dx; Dy; 0];       % A reference frame

% Euler's 1st law on rod's CM 
netForceRod2 = netForceARod2 + netForceDRod2 + gravity;        % A reference frame
euler1stLawRod2 = netForceRod2 == m*absoluteAcceleration(4:6); % DE's of motion

% Euler's 2nd law on rod's CM
netMomentRod2 = cross(CFrameToAFrame*positionARelCMRod2, netForceARod2) + cross(CFrameToAFrame*positionDRelCMRod2, netForceDRod2); % A reference frame
angularMomentumRod2 = omegaCG.*cylindricalBarMOI;                                                                                  % C reference frame
angularMomentumRod2Prime = diff(angularMomentumRod2, t) + CFrameToAFrame*cross(omegaCG, angularMomentumRod2);                      % A reference frame
euler2ndLawRod2 = netMomentRod2 == angularMomentumRod2Prime;

%% Euler's laws for rod 3

% Unknown forces acting on rod 3: 
% Bx By Cx Cy

% Rod 3 constants
positionBRelCMRod3 = [-L/2; 0; 0];                   % C reference frame
positionCRelCMRod3 = [L/2; 0; 0];                    % C reference frame
netForceBRod3 = [Bx; By; 0]; % A reference frame
netForceCRod3 = [Cx; Cy; 0];   % A reference frame

% Euler's 1st law on rod's CM 
netForceRod3 = netForceBRod3 + netForceCRod3 + gravity;        % A reference frame
euler1stLawRod3 = netForceRod3 == m*absoluteAcceleration(7:9); % DE's of motion

% Euler's 2nd law on rod's CM
netMomentRod3 = cross(CFrameToAFrame*positionBRelCMRod3, netForceBRod3) + cross(CFrameToAFrame*positionCRelCMRod3, netForceCRod3); % A reference frame
angularMomentumRod3 = omegaCG.*cylindricalBarMOI;                                                                                  % C reference frame
angularMomentumRod3Prime = diff(angularMomentumRod3, t) + CFrameToAFrame*cross(omegaCG, angularMomentumRod3);                      % A reference frame
euler2ndLawRod3 = netMomentRod3 == angularMomentumRod3Prime;

%% Euler's laws for rod 4

% Unknown forces acting on rod 4:
% Cx Cy Dx Dy

% Rod 4 constants
positionDRelCMRod4 = [-L/2; 0; 0];                     % B reference frame
positionCRelCMRod4 = [L/2; 0; 0];                      % B reference frame
netForceCRod4 = [-Cx; -Cy - springForceVertical; 0];   % A reference frame
netForceDRod4 = [-springForceHorizontal - Dx; -Dy; 0]; % A reference frame

% Euler's 1st law on rod's CM 
netForceRod4 = netForceCRod4 + netForceDRod4 + gravity;          % A reference frame
euler1stLawRod4 = netForceRod4 == m*absoluteAcceleration(10:12); % DE's of motion

% Euler's 2nd law on rod's CM
netMomentRod4 = cross(BFrameToAFrame*positionCRelCMRod4, netForceCRod4) + cross(BFrameToAFrame*positionDRelCMRod4, netForceDRod4); % A reference frame
angularMomentumRod4 = omegaBG.*cylindricalBarMOI;                                                                                  % B reference frame
angularMomentumRod4Prime = diff(angularMomentumRod4, t) + BFrameToAFrame*cross(omegaBG, angularMomentumRod4);                      % A reference frame
euler2ndLawRod4 = netMomentRod4 == angularMomentumRod4Prime;

%% PROBLEM 1: Solve the system of differential equations to find thetaDoubleDot

% All unknowns:
% Ax Ay Bx By Cx Cy Dx Dy thetaVar thetaDot thetaDoubleDot

% The system of differential equations for Euler's 1st law in the a1 and a2 directions
euler1stLawDEs = [euler1stLawRod1(1:2);
                  euler1stLawRod2(1:2);
                  euler1stLawRod3(1:2);
                  euler1stLawRod4(1:2)];
              
% The system of differential equations for Euler's 2nd law in the a3 directions
euler2ndLawDEs = [%euler2ndLawRod1(3);
                  euler2ndLawRod2(3);
                  euler2ndLawRod3(3);
                  euler2ndLawRod4(3)];

% Convert theta, diff(theta(t), t) and diff(theta(t),t,t) to theta, thetaDot and
% thetaDoubleDot, respectively. This is so these variables can be treated
% as symbolic.
euler1stLawDEs = subs(euler1stLawDEs, [theta(t), diff(theta(t),t), diff(theta(t),t,t)], [thetaVar, thetaDot, thetaDoubleDot]);
euler2ndLawDEs = subs(euler2ndLawDEs, [theta(t), diff(theta(t),t), diff(theta(t),t,t)], [thetaVar, thetaDot, thetaDoubleDot]);

% Solve the matrix.
[A,b] = equationsToMatrix( [euler1stLawDEs, euler2ndLawDEs], [Ax, Ay, Bx, By, Cx, Cy, Dx, Dy, Nx, Ny, thetaDoubleDot] );
unknownMatrix = A\b;

% The differential equation for thetaDoubleDot
thetaDoubleDotDE = unknownMatrix(11);

%% PROBLEM 2.1: Find the values of theta, thetaDot, and thetaDoubleDot using ode45()

% CASE 1: thetaInitial = 60  deg, omega = 5   deg/s
% CASE 2: thetaInitial = 60  deg, omega = 100 deg/s
% CASE 3: thetaInitial = 120 deg, omega = 5   deg/s
% CASE 4: thetaInitial = 120 deg, omega = 100 deg/s

% Define constants
timeSpan = 0:0.01:5;

% Define values for [L,m,r,g,k,lNaught] with units [m, kg, m, m/s^2, N/m, m]
constantValues2 = [1, 1, 0.05, 9.806, 25, 1];

% Define initial theta and omega conditions in radians
thetaInitial = (pi/180)*[60, 120];   % rad
thetaDotInitial = 0;                 % rad
omegaValues = (pi/180)*[5, 100];     % rad/s

% Values of theta, thetaDot, and thetaDoubleDot for each case. Each matrix
% has 4 colummn vectors, one for each case.
thetaValues =          zeros(length(timeSpan), length(thetaInitial)*length(omegaValues));
thetaDotValues =       zeros(length(timeSpan), length(thetaInitial)*length(omegaValues));
thetaDoubleDotValues = zeros(length(timeSpan), length(thetaInitial)*length(omegaValues));

caseNumber = 1;

% Obtain values for theta, thetaDot, and thetaDouble dot for each case.
for i = 1:length(thetaInitial)
    for z = 1:length(omegaValues)
        tic
        caseNumber
        
        % Solve the DE using ode45() for the initial conditions named above.
        [timeValues, x] = ode45(@evaluateThetaDoubleDot, timeSpan, [thetaInitial(i); thetaDotInitial; omegaValues(z)]);

        % Store the computed values of theta, thetaDot, and thetaDoubleDot
        thetaValues(:,caseNumber) = x(:,1);      % rad
        thetaDotValues(:, caseNumber) = x(:, 2); % rad/s
        
        % Calculate the spring force since it's a symbolic variable:
        % if theta < pi, keep spring force sign the same
        % if theta >= pi, flip the sign of the spring force
        springForceVerticalIter = ( (x(:,1) < pi) - (x(:,1) >= pi) ).*(2*L*k.*(cos(x(:,1)./2) - lNaught));
        springForceHorizontalIter = ( (x(:,1) < pi) - (x(:,1) >= pi) ).*(2*L*k.*(sin(x(:,1)./2) - lNaught));
        % Because L, k, and lNaught are symbolic, we substitute the values.
        springForceVerticalSubs = subs(springForceVerticalIter, [L, k ,lNaught], [constantValues2(1), constantValues2(5:6)]);
        springForceHorizontalSubs = subs(springForceHorizontalIter, [L, k ,lNaught], [constantValues2(1), constantValues2(5:6)]);

        % Calculate the values for theta double dot
        for iter = 1:length(x)

            % For each value of theta and thetaDot, find the corresponding
            % thetaDoubleDot value using the differential equation
            tempThetaDoubleDotValue = subs(thetaDoubleDotDE, [L,m,r,g,k,lNaught,omegaAG,thetaVar,thetaDot, springForceVertical, springForceHorizontal], [constantValues2, omegaValues(i), x(iter,1), x(iter,2), springForceVerticalSubs(iter), springForceHorizontalSubs(iter)]);
 
            % Store the computed theta double dot values
            thetaDoubleDotValues(iter,caseNumber) = tempThetaDoubleDotValue;
        end
        
        toc
        caseNumber = caseNumber + 1;
        
    end
    
end

%% PROBLEM 2.2: Make plots for theta, thetaDot, and thetaDoubleDot for each case

givenData = load('AERO310_simData.mat');

% theta vs. time
subplot(3,1,1)
plot(timeValues, thetaValues(:,1)*(180/pi), 'DisplayName', 'Our data');
hold on;
plot(timeValues, givenData.Th, 'DisplayName', 'Given data');
hold off;
title('Initial Conditions: $\theta_0 = 120^{\circ}$, $\Omega = 5^{\circ}$');
xlabel('Time (s)');
ylabel('$\theta$ ($^{\circ}$)');
legend('show');

% thetaDot vs. time
subplot(3,1,2)
plot(timeValues, thetaDotValues(:,i)*(180/pi), 'DisplayName', 'Our data');
hold on;
plot(timeValues, givenData.Thd, 'DisplayName', 'Given data');
hold off;
title('Initial Conditions: $\theta_0 = 120^{\circ}$, $\Omega = 5^{\circ}$');
xlabel('Time (s)');
ylabel('$\dot{\theta}$ ($^{\circ}/s$)');
legend('show');

% thetaDoubleDot vs. time
subplot(3,1,3)
plot(timeValues, thetaDoubleDotValues(:,i)*(180/pi), 'DisplayName', 'Our data');
hold on;
plot(timeValues, givenData.Thdd, 'DisplayName', 'Given data');
hold off;
title('Initial Conditions: $\theta_0 = 120^{\circ}$, $\Omega = 5^{\circ}$');
xlabel('Time (s)');
ylabel('$\ddot{\theta}$ $(^{\circ}/s^2)$');
legend('show');

% Plot all other graphs
for i = 1:length(thetaInitial)*length(omegaValues)
    
    % Find the plot title to use for each different case
    switch i
        case 1
            string = 'Initial Conditions: $\theta_0 = 60^{\circ}$, $\Omega = 5^{\circ}$';
        case 2
            string = 'Initial Conditions: $\theta_0 = 60^{\circ}$, $\Omega = 100^{\circ}$';
        case 3
            continue
            string = 'Initial Conditions: $\theta_0 = 120^{\circ}$, $\Omega = 5^{\circ}$';
        case 4
            string = 'Initial Conditions: $\theta_0 = 120^{\circ}$, $\Omega = 100^{\circ}$';
    end
    
    % Define the figure and default text interpreter
    figure('Name', [ 'Plots for Case #', num2str(i) ]);
    set(groot,'defaultTextInterpreter','latex');
    
    % theta vs. time
    subplot(3,1,1)
    plot(timeValues, thetaValues(:,i)*(180/pi));
    title(string);
    xlabel('Time (s)');
    ylabel('$\theta$ ($^{\circ}$)');

    % thetaDot vs. time
    subplot(3,1,2)
    plot(timeValues, thetaDotValues(:,i)*(180/pi));
    title(string);
    xlabel('Time (s)');
    ylabel('$\dot{\theta}$ ($^{\circ}/s$)');

    % thetaDoubleDot vs. time
    subplot(3,1,3)
    plot(timeValues, thetaDoubleDotValues(:,i)*(180/pi))
    title(string);
    xlabel('Time (s)');
    ylabel('$\ddot{\theta}$ $(^{\circ}/s^2)$');
end

%% PROBLEM 3: Find the equilibrium points for theta

% % Define constants for problem #3: [L,m,r,g,k,lNaught] with units [m, kg, m, m/s^2, N/m, m]
% constantValues3 = [1, 1, 0.05, 9.806, 1, 1];
% omegaValue = 5;
% 
% % Calculate the spring force vectors
% springForceVertical = 2*L*k*(cos(thetaVar/2) - lNaught);
% springForceHorizontal = 2*L*k*(sin(thetaVar/2) - lNaught);
% subs(thetaDoubleDotDE)
% springForceVValue = subs(springForceVertical, [L, k ,lNaught], [constantValues3(1), constantValues3(5:6)]);
% springForceHValue = subs(springForceHorizontal, [L, k ,lNaught], [constantValues3(1), constantValues3(5:6)]);
% 
% % Get the equation for when thetaDot and thetaDoubleDot are 0 and 
% % substitute values for all other variables in the equilibrium DE
% %equilibriumDE = 0 == subs(thetaDoubleDotDE,
% %[L,m,r,g,k,lNaught,omegaAG,springForceHorizontal],
% %[constantValues3,omegaValue,springForceHValue]);\

% % Convert thetaDoubleDotDE from symbolic to an anonymous function
% thetaDoubleDotDE1 = matlabFunction(subs(thetaDoubleDotDE));
% 
% % Make thetaDoubleDotDE2 only a function of thetaVar for use with fzero()
% thetaDoubleDotDE2 = @(thetaVar) thetaDoubleDotDE1(thetaDot, thetaVar);
% 
% % Find the roots of thetaDoubleDotDE2
% fzero(thetaDoubleDotDE2, 0.05)

thetaEquilibriumPoints = [0.2261; 0.2236; 0.2162]; % rad

%% PROBLEM 4, 5, and 6: Linearize the differential equation and find & plot the eigenvalues

% Define constants
m = 1;                   % kg
L = 1;                   % m
r = 0.05;                % m
g = 9.806;               % m/s^2
k = 1;                   % N/m
lNaught = 1;             % m
omegaAG = 5*(pi/180);    % rad/s

% Define the symbolic spring forces to be subbed into thetaDoubleDotDE
springForceVertical = 2*L*k*(cos(thetaVar/2) - lNaught);
springForceHorizontal = 2*L*k*(sin(thetaVar/2) - lNaught);

% The the derivative of the ODE wrt to theta and thetaDot
a = diff(thetaDoubleDotDE, thetaVar);
b = diff(thetaDoubleDotDE, thetaDot);

% Initialize matricies to hold the computations for each equilibrium point
c = subs(subs(a), thetaDot, 0);
d = subs(c, thetaVar, thetaEquilibriumPoints);
e = subs(b, thetaDot, 0);
f = subs(e, thetaVar, thetaEquilibriumPoints);
M1 = double([0, 1; -d(1), f(1)]);
M2 = double([0, 1; -d(2), f(2)]);
M3 = double([0, 1; -d(3), f(3)]);
eigenvalues = [eig(M1); eig(M2); eig(M3)];

% Plot the eigenvalues
figure
plot(eigenvalues, 'x') 
title('Plot of the Eigenvalues');
xlabel('Re');
ylabel('Im');
