%% Initiate SI Model.
% Define variables.
N = 106500;
I_o = 197;
r = 1.5912;
b = .2749;

% Define SI model equation.
syms t
I(t) = (N*I_o)/((N-I_o)*exp(-r*b*t)+I_o);
Iprime(t) = diff(I(t));   % This represents the theoretical SIR graph.

%% Import all data and data processing.
file = '/Users/hgducharme/Documents/MATLAB/Honors/import_data.m';
run(file);

%% Create plots for SI models.
figure('Name', 'SI Graphs');

% Plot SI model.
si_ax = subplot( 2, 2, 1 );
ezplot(I(t), [0,52,0]);
title(si_ax, 'Theoretical SI Function');
ylabel('Number of infections');
xlabel('Weeks');

% Plot integrated SIR model.
sir_ax = subplot( 2, 2, 2 );
plot(si15);
title(sir_ax, 'Integrated CDC Data');
ylabel('Number of infections');
xlabel('Weeks');

% Plot sir_approximation curve.
sir_approx_ax = subplot( 2, 2, [3,4]);
plot( si15_approx, xData, yData );
title 'Theoretical SI vs. CDC 2014-2015 Data'
legend('CDC Integrated Data', 'SI Function Approximation', 'Location', 'NorthEast' );
xlabel 'Weeks'
ylabel 'Number of infections'
grid on

axis([si_ax sir_ax, sir_approx_ax],[0 52 0 inf]);

%% Create plots for SIR models.
figure('Name', 'SIR Graphs');

% Plot CDC SIR graph from weekly influenza data.
sir15_vs_iprime = subplot( 2, 1, 1 );
plot(curve_fits{3}, xData, 1); hold on;
ezplot(Iprime(t), xData);
title(sir15_vs_iprime, 'Theoretical SIR vs. 2015 Data');
ylabel('Number of infections');
xlabel('Weeks');

% Plot differentiated SI function.
all_curves = subplot( 2, 1, 2 );
plot(x_data, thirteen_fit, 'm', x_data, fourteen_fit, 'k', x_data, fifteen_fit, 'r'); hold on;
ezplot(Iprime(t), xData);
title(all_curves, 'Theoretical SIR vs. the Past Three Influenza Seasons');
legend('2013', '2014', '2015', 'Theoretical SIR');
ylabel('Number of infections');
xlabel('Weeks');

axis([sir15_vs_iprime, all_curves],[0 52 0 inf]);

%% Create plots for normalized curves.
figure('Name', 'Normalized Curves');

% Normalized theoretical function for 2012-2013 data.
normalized_thirteen = subplot( 2, 2, 1 );
plot(xData, thirteen_fit, '--m'); hold on;
ezplot(Iprime(t)*(6239/11650), xData);
title(normalized_thirteen, 'Normalized Function for 2012-2013 Data');
legend(normalized_thirteen, '2012-2013 Data', 'Theoretical SIR');
ylabel 'Number of Infections';
xlabel 'Weeks';

% Normalized theoretical function for 2013-2014 data.
normalized_fourteen = subplot( 2, 2, 2 );
plot(xData, fourteen_fit, '--k'); hold on;
ezplot(Iprime(t)*(1796/11650), xData);
title(normalized_fourteen, 'Normalized Function for 2013-2014 Data');
legend(normalized_fourteen, '2013-2014 Data', 'Theoretical SIR');
ylabel 'Number of Infections';

% Normalized theoretical function for 2014-2015 data.
normalized_fifteen = subplot( 2, 2, [3,4] );
plot(curve_fits{3}, '--r', xData, 1); hold on;
ezplot(Iprime(t)*(13340/11650), xData);
title(normalized_fifteen, 'Normalized Function for 2014-2015 Data');
legend(normalized_fifteen, '2014-2015 Data', 'Theoretical SIR');
ylabel 'Number of Infections';
xlabel 'Weeks';

axis([normalized_thirteen, normalized_fourteen, normalized_fifteen],[0 52 0 inf]);


%% Create figures for CDC data.
% figure('name', 'CDC Data for Influenza Season 2014-2015');
% seasonal15 = plot(xData, fifteen_fit, 'ko', 'markers', 5);
% title 'CDC Data for Influenza Season 2014-2015';
% ylabel 'Number of Infections';
% xlabel 'Weeks';
% xlim([0 52]);
% 
% figure('name', 'CDC Data for Influenza Season 2013-2014');
% seasonal14 = plot(xData, fourteen_fit, 'ko', 'markers', 5);
% title 'CDC Data for Influenza Season 2013-2014';
% ylabel 'Number of Infections';
% xlabel 'Weeks';
% xlim([0 52]);
% 
% figure('name', 'CDC Data for Influenza Season 2012-2013');
% seasonal13 = plot(xData, thirteen_fit, 'ko', 'markers', 5);
% title 'CDC Data for Influenza Season 2012-2013';
% ylabel 'Number of Infections';
% xlabel 'Weeks';
% xlim([0 52]);

figure('name', 'CDC Data for Influenza Seasons 2012-2015');

data15 = subplot(3,1,1);
plot(xData, fifteen_fit, 'ko', 'markers', 5);
xlim([0 52]);
legend('2014-2015');
%title('Influenza Season 2014-2015');

data14 = subplot(3,1,2);
plot(xData, fourteen_fit, 'ko', 'markers', 5);
xlim([0 52]);
legend('2013-2014');
%title('Influenza Season 2013-2014');

data13 = subplot(3,1,3);
plot(xData, thirteen_fit, 'ko', 'markers', 5);
xlim([0 52]);
legend('2012-2013');
%title('Influenza Season 2012-2013');
xlabel 'Weeks';


%% Plot residuals. 
% figure('name', 'Residual Plots');
% 
% resi = (fifteen_fit - I(t)*(13340/11650));
% resi_15 = ezplot(resi, xData);