function [ words ] = Num2Word( number )
%Num2Word converts a number to its english equivelant.

% Base words
names1  = {'', 'one', 'two', 'three', 'four', 'five', 'six', ...
               'seven', 'eight', 'nine', 'ten', 'eleven', ...
               'twelve', 'thirteen', 'fourteen', 'fifteen', ...
               'sixteen', 'seventeen', 'eighteen', 'nineteen'};
names10 = {'', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', ...
               'seventy', 'eighty', 'ninety'};
% Convert
num100 = mod(number, 100);
if num100 < 20
    words = names1{num100+1};
    number = (number - num100) / 100;
else
    num10 = mod(number, 10);
    words = names1{num10+1};
    if ~isempty(words)
        words = [' ' words];
    end
    number = (number - num10) / 10;
    num10 = mod(number, 10);
    words = [names10{num10} words];
    number = (number - num10) / 10;
end
if number > 0
    if ~isempty(words)
        words = [' ', words];
    end
    words = [names1{number+1}, ' hundred', words];
end

end

