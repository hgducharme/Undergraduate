function [ data ] = load_data( inputFileName )
%LOAD_DATA The file name that is wish to be loaded.
%   Inputs: The current data that is being used by the program, and a
%   boolean that shows if a data file already exists.
%   Function: Checks if the file exists/if it can be found and handles
%   any errors.
%   Outputs: A data file that is known to exist.

%% Error handling

% Check to make sure that the input file exists and can be found.
while(exist(inputFileName, 'file') ~=2 )
    rehash
    warndlg('The file could not be found, or it does not exist.');
    inputFileName = input_output_file_prompt(1, 0);
    %input('\nTry again with a new file name: ','s');
end

% Make sure the data file only has between 0 and 2 columns.
while (size(load(inputFileName), 2) > 2) || size(load(inputFileName), 2) == 0
    rehash 
    inputFileName = input_output_file_prompt(1, 0);
    dlg('This program automatically refreshes the file path, so make changes to your file and it will be reflected in this program.');
    warndlg('Please input a data file with only 1 or 2 columns of data.')
    while(exist(inputFileName, 'file') ~=2 )
        rehash
        inputFileName = input_output_file_prompt(1, 0);
        warndlg('The file could not be found, or it does not exist.');
    end
end
    
    
%% Load the data

% No errors were found, so load the data.
fprintf('\nLoading data...\n');
try
    % If it is a '.mat' file, then covert it
    if strfind(inputFileName, '.mat') > 0
        data = cell2mat(struct2cell(inputFileName));
    else
        data = load(inputFileName);
    end
    fprintf('%s sucessfully loaded.\n\n', inputFileName);
catch
    data = 0;
    warndlg('\nSomething went wrong and the file could not be loaded, please try again.\n')
    return
end
