function [ ] = run_statistical_operations( data, fileID, statistics, user, dateString )
%RUN_STATISTICAL_OPERATIONS Performs statistical calculations on the input
%data.

%% Create the menu
% Open the statistical operations menu.
mtitle = sprintf('Which statistical operation would you like to perform?');
operation = menu(mtitle, 'Plot histogram', 'Plot histogram fit', ...
    'Plot probability plots', 'Find probability given x or z',   ...
    'Find x or z given probability', 'Back to main menu'         );

% Initialize variables relevant to each case.
numberOfColumns = size(data, 2);
numberOfPoints = size(data, 1);

switch operation
    
    % Plot histogram.
    case 1
        figure()
        hold on;
        for i = 1:numberOfColumns
            column = data(:, i);
            subplot(1, numberOfColumns, i); histogram(column);
            title(sprintf('Column %d', i));
        end
        hold off;
        
    % Plot histogram fit.
    case 2
        figure()
        hold on;
        for i = 1:numberOfColumns
            column = data(:, i);
            subplot(1, numberOfColumns, i); histfit(column);
            title(sprintf('Column %d', i));
        end
        hold off;
        
    % Plot probability plots.
    case 3
        figure()
        hold on;
        for i = 1:numberOfColumns
            column = data(:, i);
            subplot(1, numberOfColumns, i); probplot(column);
            title(sprintf('Column %d', i));
        end
        hold off;
        
    % Find probability given x or z.
    case 4
        % Initialize variables for this case.
        givenValue = NaN;
        normallyDistributed = -1;
        
        %% Ask user if inputting x or z value.
        
        % Construct a questdlg with three options
        choice = questdlg('Are you inputting an x value or z value?', ...
            'x Value or z Value', ...
            'x Value','z Value','x Value');
        
        % Handle response
        switch choice
            case 'x Value'
                givenValue = 'x';
            case 'z Value'
                givenValue = 'z';
        end
                
        %% Ask user if data is normally distributed.
        choice = questdlg('Is this data normally distributed?', ...
            'Normally distributed?', ...
            'Yes', 'No', 'Yes');
        switch choice
            case 'Yes'
                normallyDistributed = 1;
            case 'No'
                normallyDistributed = 0;
        end
        
        %% Perform computations based on given inputs.
        
        fprintf('\nPerforming calculations. This might take a minute...\n');
        
        % Perform the calculation if the data is normally distributed.
        if normallyDistributed == 1
            
            % Create log.
            fprintf(fileID, '[%d] %s %s\n', fileID, user, dateString);
            fprintf('[%d] %s %s\n', fileID, user, dateString);
            
            switch givenValue
                
                case 'x'
                    % Prompt user for the x value.
                    x = str2double(inputdlg('Input a scalar x value: '));
                    while ~isscalar(x)
                        warning('Please input a scalar value.')
                        x = str2double(inputdlg('Input desired x value: '));
                    end
                   
                    % Find probability for each column.
                    for i = 1:numberOfColumns
                        % Calculate probability.
                        average = statistics{2, i};
                        standardDeviation = statistics{6, i};
                        probability = normcdf(x, average, standardDeviation);
                        
                        % Print result and write it to the output file.
                        fprintf('The probability for column %d at the given x value is %.2f\n', i, probability);
                        fprintf(fileID, 'The probability for columnd %d at the given x value is %.2f\n', probability);
                    end
                    
                case 'z'
                    % Prompt user for z value.
                    z = str2double(inputdlg('Input a scalar z value: '));
                    while ~isscalar(z)
                        warning('Please input a scalar value.')
                        z = str2double(inputdlg('Input desired z value: '));
                    end
                    
                    % Find probability for each column.
                    for i = 1:numberOfColumns
                        probability = normcdf(z, 0, 1);
                        
                        % Print result and write it to the output file.
                        fprintf('The probability for column %d at the given z value is %.2f\n', i, probability);
                        fprintf(fileID, 'The probability for columnd %d at the given z value is %.2f\n', probability);
                    end

                otherwise
                    error('Something went wrong');
            end
        else
            warndlg('Calculations can not be performed on non-normal data; returning to the menu.');
        end
 
    % Find x or z given probability.
    case 5
        % Initialize variables for this case.
        wantedValue = NaN;
        normallyDistributed = -1;
        
        %% Ask user if inputting x or z value.
        
        % Construct a questdlg with three options
        choice = questdlg('Are you wanting an x value or z value?', ...
            'x Value or z Value', ...
            'x Value','z Value','x Value');
        
        % Handle response
        switch choice
            case 'x Value'
                wantedValue = 'x';
            case 'z Value'
                wantedValue = 'z';
        end
                
        %% Ask user if data is normally distributed.
        choice = questdlg('Is this data normally distributed?', ...
            'Normally distributed?', ...
            'Yes', 'No', 'Yes');
        switch choice
            case 'Yes'
                normallyDistributed = 1;
            case 'No'
                normallyDistributed = 0;
        end
        
        %% Perform computations based on given inputs.
        
        fprintf('\nPerforming calculations. This might take a minute...\n');
        
        % Perform the calculation if the data is normally distributed.
        if normallyDistributed == 1
            
            % Create log.
            fprintf(fileID, '[%d] %s %s\n', fileID, user, dateString);
            fprintf('[%d] %s %s\n', fileID, user, dateString);
            
            % Prompt user for desired probability.
            probability = str2double(inputdlg('Input desired probability (in decimal form): '));
            while ~isscalar(probability) || (probability < 0) || (probability > 1)
                warning('Please input a scalar value between 0 and 1.')
                probability = str2double(inputdlg('Input desired probability (in decimal form): '));
            end
                    
            switch wantedValue
                case 'x'                   
                    
                    % Find x value for each column.
                    for i = 1:numberOfColumns
                        % Calculate the x value.
                        average = statistics{2, i};
                        standardDeviation = statistics{6, i};
                        x = norminv(probability, average, standardDeviation);
                        
                        % Print result and write it to the output file.
                        fprintf('\nThe x value for column %d at %0.2f% probability is %.2f\n', i, x);
                        fprintf(fileID, '\nThe x value for column %d at %0.2f% probability is %.2f\n', i, x);
                    end
                    
                case 'z'
                    
                    % Find z value for each column.
                    for i = 1:numberOfColumns
                        z = norminv(probability, 0, 1);
                        
                        % Print result and write it to the output file.
                        fprintf('The z value for column %d at %0.2f% probability is %.2f\n', i, z);
                        fprintf(fileID, '\nThe z value for column %d at %0.2f% probability is %.2f\n', i, z);
                    end

                otherwise
                    error('Something went wrong');
            end
        else
            warndlg('Calculations can not be performed on non-normal data; returning to the menu.');
        end
        
    % Go back to main menu.
    case 6
        return
        
    otherwise
        fprintf('Please click one of the options. If you no longer want to be here, click ''Back to main menu''.\n');
end

end

