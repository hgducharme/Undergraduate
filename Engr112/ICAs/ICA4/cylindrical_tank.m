% Constants and variables.
H = 20; % meters, height of the tank.
h = 0;   % meters, height of the liquid in the tank.
r = 2;   % meters, radius of the spherical cap.
V = 0;   % m^3, volume of the liquid in the tank.

while h >= 0
    h = input('\n\nEnter a value for the height, in meters, of the liquid in the tank: ');
    
    if (h > H) || (~isreal(h))
        error('\n\nThe height of the liquid must be a real number between 0 and %i meters', H);
        continue  %#ok<UNRCH>
    end
    
    if (h-r) <= 0
        V = (1/3)*(pi)*(h^2)*(3*r - h);
        fprintf('The volume of the liquid in the tank is: %0.2f m^3', V);
    elseif (h-r) > 0
        V = (2/3)*pi*(r^3) + (pi*r^2)*(h-r);
        fprintf('The volume of the liquid in the tank is: %0.2f m^3', V);
    elseif h > (h-r)
        V = (pi*r^2)*(H-2*r) + (4/3)*(pi)*(r^3) - (1/3)*(pi)*((H-h)^2)*(3*r-H+h);
        fprintf('The volume of the liquid in the tank is: %0.2f m^3', V);
    else 
        fprintf('The volume could not be computed.');
    end
    
end