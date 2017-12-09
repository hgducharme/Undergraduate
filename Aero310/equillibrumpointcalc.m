clear;clc;
m=1;
L=1;
r=0.05;
g=9.806;
k=1;
lNaught=1;
% omegaAG=5*(pi/180);
% omegaAG=45*(pi/180);
% omegaAG=90*(pi/180);
thetaDot=0;
omegaAG=5*(pi/180);
%%thdd=@(thetaVar) -(2*(6*L*2*L*k*(cos(thetaVar/2) - lNaught)*sin(thetaVar/2) - 6*L*2*L*k*(sin(thetaVar/2) - lNaught)*cos(thetaVar/2) + 12*L*g*m*sin(thetaVar/2) + 2*L^2*m*omegaAG^2*cos(thetaVar/2)*sin(thetaVar/2) - 3*L^2*m*thetaDot^2*cos(thetaVar/2)*sin(thetaVar/2) + 3*m*omegaAG^2*r^2*cos(thetaVar/2)*sin(thetaVar/2)))/(L^2*m + 3*m*r^2 - 3*L^2*m*cos(thetaVar/2)^2 - 15*L^2*m*sin(thetaVar/2)^2);
thdd= @(thetaVar) -(2*(12*L^2*k*cos(thetaVar/2)*(lNaught - sin(thetaVar/2)) - 12*L^2*k*sin(thetaVar/2)*(lNaught - cos(thetaVar/2)) + 12*L*g*m*sin(thetaVar/2) + 2*L^2*m*omegaAG^2*cos(thetaVar/2)*sin(thetaVar/2) - 3*L^2*m*thetaDot^2*cos(thetaVar/2)*sin(thetaVar/2) + 3*m*omegaAG^2*r^2*cos(thetaVar/2)*sin(thetaVar/2)))/(L^2*m + 3*m*r^2 - 3*L^2*m*cos(thetaVar/2)^2 - 15*L^2*m*sin(thetaVar/2)^2);
d1=fzero(thdd,omegaAG);

omegaAG=45*(pi/180);
%%thdd1=@(thetaVar) -(2*(6*L*2*L*k*(cos(thetaVar/2) - lNaught)*sin(thetaVar/2) - 6*L*2*L*k*(sin(thetaVar/2) - lNaught)*cos(thetaVar/2) + 12*L*g*m*sin(thetaVar/2) + 2*L^2*m*omegaAG^2*cos(thetaVar/2)*sin(thetaVar/2) - 3*L^2*m*thetaDot^2*cos(thetaVar/2)*sin(thetaVar/2) + 3*m*omegaAG^2*r^2*cos(thetaVar/2)*sin(thetaVar/2)))/(L^2*m + 3*m*r^2 - 3*L^2*m*cos(thetaVar/2)^2 - 15*L^2*m*sin(thetaVar/2)^2);
thdd1= @(thetaVar) -(2*(12*L^2*k*cos(thetaVar/2)*(lNaught - sin(thetaVar/2)) - 12*L^2*k*sin(thetaVar/2)*(lNaught - cos(thetaVar/2)) + 12*L*g*m*sin(thetaVar/2) + 2*L^2*m*omegaAG^2*cos(thetaVar/2)*sin(thetaVar/2) - 3*L^2*m*thetaDot^2*cos(thetaVar/2)*sin(thetaVar/2) + 3*m*omegaAG^2*r^2*cos(thetaVar/2)*sin(thetaVar/2)))/(L^2*m + 3*m*r^2 - 3*L^2*m*cos(thetaVar/2)^2 - 15*L^2*m*sin(thetaVar/2)^2);

d2=fzero(thdd1,omegaAG);

omegaAG=90*(pi/180);
%%thdd2=@(thetaVar) -(2*(6*L*2*L*k*(cos(thetaVar/2) - lNaught)*sin(thetaVar/2) - 6*L*2*L*k*(sin(thetaVar/2) - lNaught)*cos(thetaVar/2) + 12*L*g*m*sin(thetaVar/2) + 2*L^2*m*omegaAG^2*cos(thetaVar/2)*sin(thetaVar/2) - 3*L^2*m*thetaDot^2*cos(thetaVar/2)*sin(thetaVar/2) + 3*m*omegaAG^2*r^2*cos(thetaVar/2)*sin(thetaVar/2)))/(L^2*m + 3*m*r^2 - 3*L^2*m*cos(thetaVar/2)^2 - 15*L^2*m*sin(thetaVar/2)^2);
thdd2= @(thetaVar) -(2*(12*L^2*k*cos(thetaVar/2)*(lNaught - sin(thetaVar/2)) - 12*L^2*k*sin(thetaVar/2)*(lNaught - cos(thetaVar/2)) + 12*L*g*m*sin(thetaVar/2) + 2*L^2*m*omegaAG^2*cos(thetaVar/2)*sin(thetaVar/2) - 3*L^2*m*thetaDot^2*cos(thetaVar/2)*sin(thetaVar/2) + 3*m*omegaAG^2*r^2*cos(thetaVar/2)*sin(thetaVar/2)))/(L^2*m + 3*m*r^2 - 3*L^2*m*cos(thetaVar/2)^2 - 15*L^2*m*sin(thetaVar/2)^2);

d3=fzero(thdd2,omegaAG);

