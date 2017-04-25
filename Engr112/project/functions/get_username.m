function [ username, specified_date ] = get_username( )
%GET_USERNAME Prompts the user for a username and date.

dialog_title = 'Welcome to the Data Analysis room!';
prompt = {'Please enter your name:', 'Please enter today''s date (mm/dd/yy):'};
default_answers = {'username', datestr(date, 'mm/dd/yy')};
window_size = [1 75; 1 75];
options.Resize = 'on';
answers = inputdlg(prompt, dialog_title, window_size, default_answers, options);
username = answers{1};
specified_date = answers{2};

end

