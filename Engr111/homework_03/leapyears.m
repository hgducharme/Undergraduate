function [ ] = leapyears( start, last )
%LEAPYEARS computes all the leap years between the given start and end
%years.

for i=start:1:last
    if mod(i, 100) == 0
        if mod(i, 400) == 0
            disp(i);
        end
    elseif mod(i, 4) == 0
        disp(i);
    end
end
        


end

