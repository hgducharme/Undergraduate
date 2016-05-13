%% Import data from text file.
% Script for importing data from the following directory:
%
%    /Users/hgducharme/Documents/MATLAB/Honors/Data/

%% Import all data from each .csv file.
directory = ('/Users/hgducharme/Documents/MATLAB/Honors/Data/');
csvfiles = dir(fullfile(directory,'*.csv'));
data_matrix = zeros(52, 4);
data_matrix(:,1) = 1:52;

for file = 1:numel(csvfiles)
    delimiter = ',';
    startRow = 2;
    formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
    
    filename = fullfile(directory, csvfiles(file).name);
    fileID = fopen(filename,'r');
    if fileID < 0
        error('Failed to open file %s', filename);
    end
    
    data = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID);
    
    influenza_a = data{:, 6} + data{:, 8};
    if size(influenza_a) ~= size(data_matrix)
       influenza_a(end) = [];
    end
    data_matrix(:, 1+file) = influenza_a;
end


%% Create output variable
Influenza = array2table(data_matrix, 'VariableNames', {'WEEK', 'Thirteen','Fourteen','Fifteen'});

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;


%% Fit curves for each year in the table.

curve_fits = {};
iter = 0;
for column = Influenza(:,2:4)
    iter = iter + 1;
    
    % Generate curve fit.
    [x_data, y_data] = prepareCurveData( 1:52 , column{1:52,:} );

    % Set up fittype and options.
    ft = fittype( 'smoothingspline' );
    opts = fitoptions( 'Method', 'SmoothingSpline' );
    opts.SmoothingParam = 1;

    % Fit model to data.
    [spline{iter}, influenza_gof] = fit( x_data, y_data, ft, opts ); %#ok<SAGROW>
    curve_fits{iter} = spline{iter}; %#ok<SAGROW>
end

% These functions are the curve fits plotted on the x_data data set.
x_data = 1:52;
thirteen_fit = curve_fits{1}(x_data);
fourteen_fit = curve_fits{2}(x_data);
fifteen_fit = curve_fits{3}(x_data);

%% Integrate SIR function for 2015 Influenza.
si15 = integrate(curve_fits{3}, x_data, 0);


%% Fit theoretical SIR to CDC SIR.
[xData, yData] = prepareCurveData( x_data, si15 );

% Set up fittype and options.
ft2 = fittype( '(106500*197)/((106500-197)*exp(-r*b*t)+197);', 'independent', 't', 'dependent', 'I' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [6 0.4];

% Fit model to data.
[si15_approx, si15_approx_gof] = fit( xData, yData, ft2, opts );

% Display coefficient values.
disp('The values of r & b respectively are:');
disp(coeffvalues(si15_approx));
reproduction_number = (1.28)/(si15_approx.r * si15_approx.b);
fprintf('The average infectious period is: %6.2f days \n \n', reproduction_number);