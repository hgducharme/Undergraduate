function [ statistics ] = mystat( data, fileID, user, dateString )
%MY_STAT Computes outputs basic statistical properties of the input data.
   % statistics = [ Column #;
   %                mean; 
   %                median;
   %                mode; 
   %                variance;
   %                standard deviation;
   %                minimum value; 
   %                maximum value; 
   %                number of items;
   %                string about kind of standard deviation used ]

%% Get the statistics for the data.

% Initialize the array that will store the statistics for each column.
numberOfColumns = size(data,2);
statistics = cell(10, numberOfColumns);

% Perform the statistics for each column in the data file.
for k = 1:numberOfColumns
    % Get the current column of the data file
    column = data(:,k);
    
    % If the column length is > 30, use population standard deviation. 
    % population stdev: flag = 0
    % normalized stdev: flag = 1
    flag = NaN;
    msg = '';
    if length(column) > 30
        flag = 0;
        msg = 'Population standard deviation.';
    else
        flag = 1;
        msg = 'Sample standard deviation.';
    end
    
    % Store all of the computations in a cell array.
    statistics(:,k) = {k; ...
        mean(column);      ...
        median(column);    ...
        mode(column);      ...
        var(column);       ...
        std(column, flag); ...
        min(column);       ...
        max(column);       ...
        length(column);    ...
        msg                };
end

%% Handle the statistics data.

fprintf('Printing the statistics for each column:\n', user, dateString);

% Create log.
fprintf(fileID, '[%d] %s %s\n', fileID, user, dateString);
fprintf('[%d] %s %s\n', fileID, user, dateString);

% Print statistics to console and write the statistics to the output file.
for i = 1:numberOfColumns
    % Write the statistics to the output data file.
    fprintf(fileID, 'Mean          = %0.2f\n', statistics{2, i});
    fprintf(fileID, 'Median        = %0.2f\n', statistics{3, i});
    fprintf(fileID, 'Mode          = %0.2f\n', statistics{4, i});
    fprintf(fileID, 'Variance      = %0.2f\n', statistics{5, i});
    fprintf(fileID, 'Standard Dev. = %0.2f\n', statistics{6, i});
    fprintf(fileID, 'Minimum       = %0.2f\n', statistics{7, i});
    fprintf(fileID, 'Maximum       = %0.2f\n', statistics{8, i});
    fprintf(fileID, 'Count         = %d\n', statistics{9, i});
    fprintf(fileID, '%s\n\n', msg);

    % Print the statistics to the console.
    fprintf('Mean          = %0.2f\n', statistics{2, i});
    fprintf('Median        = %0.2f\n', statistics{3, i});
    fprintf('Mode          = %0.2f\n', statistics{4, i});
    fprintf('Variance      = %0.2f\n', statistics{5, i});
    fprintf('Standard Dev. = %0.2f\n', statistics{6, i});
    fprintf('Minimum       = %0.2f\n', statistics{7, i});
    fprintf('Maximum       = %0.2f\n', statistics{8, i});
    fprintf('Count         = %d\n', statistics{9, i});
    fprintf('%s\n\n', msg);
end



end

