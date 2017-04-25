function [ inputFileName, outputFileName ] = input_output_file_prompt( inputBoolean, outputBoolean )
%INPUT_OUTPUT_FILE_PROMPT prompts the user for an input file name and an
%output file name.

% Variables for the dialog box.
dialog_title = 'Data files';

% Initialize variables.
prompt = {};
default_answers = {};

if inputBoolean == 1 && outputBoolean == 1
    % Window size of the dialog.
    window_size = [1 80; 1 80];
    
    % Prompt and default answers for this case.
    prompt{1} = 'File to load (with its extension):';
    prompt{2} = 'Output file name (without extension):';
    default_answers{1} = 'file.extension';
    default_answers{2} = 'file_name';
    answers = inputdlg(prompt, dialog_title, window_size, default_answers);
    
    % Answers to return.
    inputFileName = answers{1};
    outputFileName = answers{2};
    
elseif inputBoolean == 1 && outputBoolean == 0
    % Window size of the dialog.
    window_size = [1 80];
    
    % Prompt and default answers for this case.
    prompt{1} = 'File to load (with its extension):';
    default_answers{1} = 'file.extension';
    answers = inputdlg(prompt, dialog_title, window_size, default_answers);
    
    % Answers to return.
    inputFileName = answers{1};
    outputFileName = NaN;
    
elseif inputBoolean == 0 && outputBoolean == 1
    % Window size of the dialog.
    window_size = [1 80];
    
    % Prompt and default answers for this case.
    prompt{1} = 'Output file name (without extension):';
    default_answers{1} = 'file_name';
    answers = inputdlg(prompt, dialog_title, window_size, default_answers);
    
    % Answers to return.
    inputFileName = NaN;
    outputFileName = answers{1};

else
    error('Something went wrong.');
end