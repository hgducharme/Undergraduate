%% Known quantities
syms L m g r theta(t) omegaAG(t) transport

% Constants and reference frames
gravity = [0; -m*g; 0];                    % A or G reference frame
omega = [0; -omegaAG(t); 0];               % A or G reference frame

% Angular momentum of frame B relative to frame G
omegaBG = [-omegaAG(t)*cos(theta(t)/2);...
           omegaAG(t)*sin(theta(t)/2);...
           -(1/2)*diff(theta(t),t)];       % B reference frame
       
% Angular momentum of frame C relative to frame G
omegaCG = [-omegaAG(t)*cos(theta(t)/2);...
           omegaAG(t)*sin(theta(t)/2);...
           (1/2)*diff(theta(t),t)];        % C reference frame

% [a1; a2; a3] = (...)(b1; b2; b3]
BFrameToAFrame = [-sin(theta(t)/2), -cos(theta(t)/2), 0;...
                    cos(theta(t)/2), -sin(theta(t)/2), 0;...
                    0, 0, 1];
                
% [a1; a2; a3] = (...)(c1; c2; c3]
CFrameToAFrame = [sin(theta(t)/2), cos(theta(t)/2), 0;...
                  cos(theta(t)/2), -sin(theta(t)/2), 0;...
                  0, 0, 1];

% Moment of inertia for a cylindrical bar relative to its principal-axis
% coordinate system
cylindricalBarMOI = [(m/2)*r^2;...
                     (m/12)*(3*r^2 + L^2);...
                     (m/12)*(3*r^2 + L^2)];

% Position vectors
r1 = (L/2)*[-sin(theta(t)/2); cos(theta(t)/2); 0]; % A reference frame
r2 = (L/2)*[ sin(theta(t)/2); cos(theta(t)/2); 0]; % A reference frame
r3 = 2*r1 + (L/2)*[ sin(theta(t)/2); cos(theta(t)/2); 0]; % A reference frame
r4 = 2*r2 + (L/2)*[-sin(theta(t)/2); cos(theta(t)/2); 0]; % A reference frame
position = [r1; r2; r3; r4];

%% Velocity vectors

localVelocity = diff(position, t);                  % Velocity relative to the spinning reference frame
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

%% Rod 1

syms Ax Ay Bx By k lNaughtV lNaughtH

% Rod 1 constants
positionARelCMRod1 = [-L/2; 0; 0];              % B reference frame
positionBRelCMRod1 = [L/2; 0; 0];               % B reference frame
netForceARod1 = [Ax; k*(2*L*cos(theta(t)/2)-lNaughtV) - Ay; 0];  % A reference frame
netForceBRod1 = [k*(2*L*sin(theta(t)/2)-lNaughtH) + Bx; -By; 0]; % A reference frame

% Euler's 1st law on rod's CM 
netForceRod1 = netForceARod1 + netForceBRod1 + gravity;        % A reference frame
euler1stLawRod1 = netForceRod1 == m*absoluteAcceleration(1:3); % DE's of motion

% Euler's 2nd law on rod's CM 
netMomentRod1 = cross(BFrameToAFrame*positionARelCMRod1, netForceARod1) + cross(BFrameToAFrame*positionBRelCMRod1, netForceBRod1); % A reference frame
angularMomentumRod1 = omegaBG.*cylindricalBarMOI;                                                                                  % B reference frame
angularMomentumRod1Prime = diff(angularMomentumRod1, t) + BFrameToAFrame*cross(omegaBG, angularMomentumRod1);                      % A reference frame
euler2ndLawRod1 = netMomentRod1 == angularMomentumRod1Prime;

%% Rod 2

syms Ax Ay Dx Dy k lNaughtV lNaughtH

% Rod 2 constants
positionARelCMRod2 = [-L/2; 0; 0];              % C reference frame
positionDRelCMRod2 = [L/2; 0; 0];               % C reference frame
netForceARod2 = [-Ax; k*(2*L*cos(theta(t)/2)-lNaughtV) + Ay; 0]; % A reference frame
netForceDRod2 = [-k*(2*L*sin(theta(t)/2)-lNaughtH) + Dx; Dy; 0]; % A reference frame

% Euler's 1st law on rod's CM 
netForceRod2 = netForceARod2 + netForceDRod2 + gravity;        % A reference frame
euler1stLawRod2 = netForceRod2 == m*absoluteAcceleration(4:6); % DE's of motion

% Euler's 2nd law on rod's CM
netMomentRod2 = cross(CFrameToAFrame*positionARelCMRod2, netForceARod2) + cross(CFrameToAFrame*positionDRelCMRod2, netForceDRod2); % A reference frame
angularMomentumRod2 = omegaCG.*cylindricalBarMOI;                                                                                  % C reference frame
angularMomentumRod2Prime = diff(angularMomentumRod2, t) + CFrameToAFrame*cross(omegaCG, angularMomentumRod2);                      % A reference frame
euler2ndLawRod2 = netMomentRod2 == angularMomentumRod2Prime;

%% Rod 3

syms Bx By Cx Cy k lNaughtV lNaughtH

% Rod 3 constants
positionBRelCMRod3 = [-L/2; 0; 0];             % C reference frame
positionCRelCMRod3 = [L/2; 0; 0];              % C reference frame
netForceBRod3 = [k*(2*L*sin(theta(t)/2)-lNaughtH) - Bx; By; 0]; % A reference frame
netForceCRod3 = [Cx; Cy - k*(2*L*cos(theta(t)/2)-lNaughtV); 0]; % A reference frame

% Euler's 1st law on rod's CM 
netForceRod3 = netForceBRod3 + netForceCRod3 + gravity;        % A reference frame
euler1stLawRod3 = netForceRod3 == m*absoluteAcceleration(7:9); % DE's of motion

% Euler's 2nd law on rod's CM
netMomentRod3 = cross(CFrameToAFrame*positionBRelCMRod3, netForceBRod3) + cross(CFrameToAFrame*positionCRelCMRod3, netForceCRod3); % A reference frame
angularMomentumRod3 = omegaCG.*cylindricalBarMOI;                                                                                  % C reference frame
angularMomentumRod3Prime = diff(angularMomentumRod3, t) + CFrameToAFrame*cross(omegaCG, angularMomentumRod3);                      % A reference frame
euler2ndLawRod3 = netMomentRod3 == angularMomentumRod3Prime;

%% Rod 4

syms Cx Cy Dx Dy k lNaughtV lNaughtH

% Rod 4 constants
positionDRelCMRod4 = [-L/2; 0; 0];                                   % B reference frame
positionCRelCMRod4 = [L/2; 0; 0];                                    % B reference frame
netForceDRod4 = [-k*(2*L*sin(theta(t)/2)-lNaughtH) - Dx; -Dy; 0];    % A reference frame
netForceCRod4 = [-Cx; -Cy - k*(2*L*cos(theta(t)/2)-lNaughtV); 0];    % A reference frame

% Euler's 1st law on rod's CM 
netForceRod4 = netForceCRod4 + netForceDRod4 + gravity;          % A reference frame
euler1stLawRod4 = netForceRod4 == m*absoluteAcceleration(10:12); % DE's of motion

% Euler's 2nd law on rod's CM
netMomentRod4 = cross(BFrameToAFrame*positionCRelCMRod4, netForceCRod4) + cross(BFrameToAFrame*positionDRelCMRod4, netForceDRod4); % A reference frame
angularMomentumRod4 = omegaBG.*cylindricalBarMOI;                                                                                  % B reference frame
angularMomentumRod4Prime = diff(angularMomentumRod4, t) + BFrameToAFrame*cross(omegaBG, angularMomentumRod4);                      % A reference frame
euler2ndLawRod4 = netMomentRod4 == angularMomentumRod4Prime;

%% System of Differential Equations for the Entire System

% The system of differential equations for Euler's 1st law in the a1 and a2 directions
euler1stLawDEs = [euler1stLawRod1(1:2);
                  euler1stLawRod2(1:2);
                  euler1stLawRod3(1:2);
                  euler1stLawRod4(1:2)];
              
% The system of differential equations for Euler's 2nd law in the a3 directions
euler2ndLawDEs = [euler1stLawRod1(3);
                  euler1stLawRod2(3);
                  euler1stLawRod3(3);
                  euler1stLawRod4(3)];