% 1. Load the data
clc; clear; close;
data = load('fitdata.mat');

% 2. Make a scatterplot of y as a function of x using black circles.
x = data.x;
y = data.y;
yfit = data.yfit;

figure
plot(x, y, 'ko');
hold on

% 3. On the same graph, plot the fitted curve yfit using a solid line with thickness of 2.
plot(x, yfit, 'k', 'LineWidth', 2);
hold on

% 4. On the same graph plot upper and lower bound of the fitted curve, 
% 0.3 above and below the fitted curve, using red dashed lines of thickness 2. 
upper_bound = yfit + 0.3;
lower_bound = yfit - 0.3;
plot(x, upper_bound, 'r--', x, lower_bound, 'r--', 'LineWidth', 2);

% 5. Put a legend and axis labels on the graph.
xlabel('x data');
ylabel('y data and fit');
legend('Data', 'Fit', 'Lower/Upper Bounds', 'Location', 'northwest');