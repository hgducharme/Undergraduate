%DO_YOU_EVEN_SCRIPT computes the Gregorian epact.
% DO_YOU_EVEN_SCRIPT is a long and not-so-simple script that computes the
% Gregorian epact.
%
% The Gregorian epact is the number of days between January 1st and the
% previous new moon.

% prompt for 4 digit year
year = input('4-digit year: ','s');
% convert to number
year = str2double(year);
if isnumeric(year)
 % check that year is 4 digits
 if and( year >= 1000 , year <= 9999 )
 C = year;
 C = C / 100;
 C = fix(C);
 epact = 8;
 tmp = C;
 tmp = tmp / 4;
 tmp = fix(tmp);
 epact = epact + tmp;
 epact = epact - C;
 tmp = 8;
 tmp = tmp * C;
 tmp = tmp + 13;
 tmp = tmp / 25;
 tmp = fix(tmp);
 epact = epact + tmp;
 tmp = year;
 tmp = rem(tmp,19);
 tmp = tmp * 11;
 epact = epact + tmp;
 epact = rem(epact,30);

 % print result
 fprintf('epact: %d\n', epact);

 else
 % year is not 4 digits
 fprintf(2,'Error: year must be 4 digits\n');
 end
else
 % year is not a number
 fprintf(2,'Error: year must be a number\n');
end