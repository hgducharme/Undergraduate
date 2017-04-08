function [ cost ] = parking_fee( hours_parked )
%PARKING_FEE computes the total parking cost
%   PARKING_FEE takes the number of hours parked and computes the total
%   cost based on the fee structure of the garage. 
%
%   A lost ticket is signified using a negative value for hours.
%   Partial hours are charges as full hours. 
%   0-2 hours = $4, 2-4 hours = $3.
%   Each additional hour = $1.
%   Maximum daily charge = $24.
%   Lost ticket charge = $36.

% Constants
ABSOLUTE_HOURS = abs(hours_parked);
% All units in dollars.
TWO_HOURS = 4;
FOUR_HOURS = 7;
ADDITIONAL_HOUR = 1;
MAX_DAILY_CHARGE = 24;
LOST_TICKET = 36;

% Variables
cost = 0;

% Processing
% Cost for less than 2 hours
if ABSOLUTE_HOURS <= 2 && ABSOLUTE_HOURS > 0
    cost = TWO_HOURS;

% Cost for greater than 2, less than 4 hours
elseif ABSOLUTE_HOURS <= 4 && ABSOLUTE_HOURS > 2 
    cost = FOUR_HOURS;
    
% Cost for greater than 4, less than 24 hours
elseif ABSOLUTE_HOURS > 4 && ABSOLUTE_HOURS < 24 
    additionalHours = ABSOLUTE_HOURS - 4;
    cost = FOUR_HOURS + additionalHours;
    if cost > 24
        cost = MAX_DAILY_CHARGE;
    end
    
% Cost for greater than 24 hours    
elseif ABSOLUTE_HOURS >= 24 
   numberOfDays = floor(ABSOLUTE_HOURS / 24);           % Integer number of days
   remainingHours = ABSOLUTE_HOURS - (numberOfDays*24); % Did they park for a decimal number of days?
   chargeForDays = numberOfDays*MAX_DAILY_CHARGE;
   if remainingHours <= 2 && remainingHours > 0 
       cost = chargeForDays + TWO_HOURS;
   elseif remainingHours <= 4 && remainingHours > 2 
       cost = chargeForDays + FOUR_HOURS; 
   elseif remainingHours > 4 && remainingHours < 24 
       additionalHours = remainingHours - 4;
       remainingHoursCost = FOUR_HOURS + additionalHours;
       if remainingHoursCost > 24
        cost = MAX_DAILY_CHARGE + chargeForDays;
       else
           cost = remainingHoursCost + chargeForDays;
    end
   else 
       cost = chargeForDays;
   end
end

% Add cost of lost ticket if hours_parked is negative
if hours_parked < 0
    cost = cost + LOST_TICKET;
end
        
fprintf('Your total cost is: $%.0f.\n', cost);
end

