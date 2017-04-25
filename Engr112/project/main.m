clc; clear; close all;

%% Initialize global variables that do not reset after each loop iteration.

% Initialize global variables.
continueProgram = true;

% Initialize username and date.
[username, date] = get_username();

% Prompt the user for an input file name and the name of the output file.
[inputFileName, outputFileName] = input_output_file_prompt(1,1);

%%%%%%% TODO: MATLAB's uigetfile() helps simplify the loading a datafile
%%%%%%% process.
% Load the data file and create an output file.
dataFile = load_data(inputFileName);
fileID = fopen(outputFileName, 'a');

% If there is an error opening the file, continue to try again.
while fileID < 0 
    [inputFileName, outputFileName] = input_output_file_prompt(0,1);
    fileID = fopen(outputFileName, 'a');
end

% Perform basic statistics on data file and write results to output file.
[statistics] = mystat(dataFile, fileID, username, date);

%% Operate the menu driven data analysis
while continueProgram == true
	choice = open_main_menu(username);
    
	switch choice
        % Set username
        case 1
            temp = username;
            username = inputdlg('\nEnter a username: ', 's');
            fprintf('\nSucessfully changed username from ''%s'' to ''%s''!\n', ... 
                temp, username);
            
        % Load a different data file.
		case 2
            % Check to see if a data file already exists.
            if exists('dataFile', 'var')
                errordlg('A data file already exists. Please clear the memory before creating another file.');
                continue
            end
            
            % If no data file exists, prompt the user for a file name.
            [inputFileName, outputFileName] = input_output_file_prompt(1,1);
            
            % Load the data file into the memory.
            dataFile = load_data(inputFileName);
         
        % Create a different output file.
        case 3
            % Make sure there is a data file in order to create an output
            % file.
            if ~exist('dataFile', 'var')
                warndlg('Please load a data file before specifying an output file.');
                continue;
            end
            
            % Check to see if an output file already exists.
            if exist('fileID', 'var') && (fileID >= 3)
                errordlg('An output file already exists. Please clear the memory before creating another file.');
                continue
            end
            
            % Prompt the user for an output file name.
            [inputFileName, outputFileName] = input_output_file_prompt(0,1);
            
            % If the file already exists, continue to prompt for 
            while exist(outputFileName, 'file') == 2
                warndlg('An output file already exists with this name.');
                [inputFileName, outputFileName] = input_output_file_prompt(0,1);
            end
            
            % Initialize the output file with the input file name.
            fileID = fopen(outputFileName, 'a');

            % If there is an error opening the file, continue to try again.
            while fileID < 0 
                [inputFileName, outputFileName] = input_output_file_prompt(0,1);
                fileID = fopen(outputFileName, 'a');
            end
            
            % Perform basic statistics on data file and write results to output file.
            [statistics] = mystat(dataFile, fileID, username, date);

        % Statistical operations
		case 4
            % Check if there is a data file and an output file.
            if exist('dataFile', 'var') == 1 && (fileID >= 3) == true
                run_statistical_operations(dataFile, fileID, statistics, username, date);
            else
                errordlg('Make sure there is a data file and an output file before performing calculations');
                continue;
            end
        
        % Clear all data from the memory
		case 5
            clearvars -except continueProgram dataFileBoolean username
            
        % Exit the program
        case 6            
            continueProgram = false;
            clc; close all;
            
        otherwise
			fprintf('Please click one of the options. If you no longer want to be here, click ''Exit''.\n');
	end
end