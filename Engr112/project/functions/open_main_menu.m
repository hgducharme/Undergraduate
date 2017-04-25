function [ selection ] = open_main_menu( username )
%PRINT_MAIN_MENU Prints the main menu of the script.
mtitle = sprintf('What do you want to do, %s?', username);
selection = menu(mtitle, 'Reset username', 'Load a different data file',    ...
                  'Create a different output file', 'Perform data anlysis', ...
                  'Clear data from memory',  'Exit');
end

