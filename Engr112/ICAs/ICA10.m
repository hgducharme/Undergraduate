%% 1. Make a plot for the temperature of the oven.
clc; clear; close all;

TSet = 700;   % Celcius
Gp = 1:1:100; % Gain
TAct = TSet./(1 + Gp);
plot(Gp, TAct);

%% 2. Include realistic wind resistance in the model.
clc; clear; close all;

INERTIA = 20;
PROPORTIONAL_CONTROLLER = 20;
RESISTANCE = 0.04;
DESIRED_SPEED = 65;
TIME_STEP = 0.1;

TimeValues = 0:TIME_STEP:40;
Speed(1:2) = 0;

for i = 2:length(TimeValues)-1
    a = (3*RESISTANCE*TIME_STEP/INERTIA);
    b = PROPORTIONAL_CONTROLLER*(TIME_STEP^2)/INERTIA;
    
    Speed(i+1) = 2*Speed(i)-Speed(i-1) ...
        - a*(Speed(i)^2)*(Speed(i)-Speed(i-1)) ...
        - b*(Speed(i) - DESIRED_SPEED);
end

figure
plot(TimeValues, Speed)
xlabel('Time (sec)');
ylabel('Speed (mph)');

%% 3. Change C to 0.05;
clc; clear; close all;

INERTIA = 20;
PROPORTIONAL_CONTROLLER = 20;
RESISTANCE = 0.05;
DESIRED_SPEED = 65;
TIME_STEP = 0.1;

TimeValues = 0:TIME_STEP:40;
Speed(1:2) = 0;

for i = 2:length(TimeValues)-1
    a = (3*RESISTANCE*TIME_STEP/INERTIA);
    b = PROPORTIONAL_CONTROLLER*(TIME_STEP^2)/INERTIA;
    
    Speed(i+1) = 2*Speed(i)-Speed(i-1) ...
        - a*(Speed(i)^2)*(Speed(i)-Speed(i-1)) ...
        - b*(Speed(i) - DESIRED_SPEED);
end

figure
plot(TimeValues, Speed)
xlabel('Time (sec)');
ylabel('Speed (mph)');

%% 4. Plot height of water vs. time.

AREA = 10;                     % m^2
MAX_HEIGHT = 4;                % m
PROPORTIONAL_CONTROLLER = 0.2; % m^2/min
TIME_STEP = 1;                 % min
R_FLOW = 10;                   % min/m^2

c1 = (1 - (TIME_STEP/(R_FLOW*AREA)));
c2 = PROPORTIONAL_CONTROLLER*TIME_STEP/AREA;

Time = 1:TIME_STEP:100;
Height = zeros(1, length(Time));
Height(1) = 0;

for i = 2:length(Time)
    Height(i) = c1*Height(i-1) + c2*(MAX_HEIGHT - Height(i-1));
end

figure
plot(Time, Height);
xlabel('Time (min)');
ylabel('Height (m)');
