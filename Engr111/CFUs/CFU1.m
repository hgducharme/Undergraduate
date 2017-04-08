% Constants
PRICE_PER_POUND = 12;
SHIPPING_PER_POUND = 0.86;
SHIPPING_FLAT_FEE = 1.50;

% Variables
pounds = input('Please specify how many pounds of coffee beans you would like to buy: ');

% Processing
totalCost = (pounds)*(PRICE_PER_POUND) + (pounds)*(SHIPPING_PER_POUND) + SHIPPING_FLAT_FEE;

% Output
fprintf('Your total cost will be: $%.2f\n', totalCost);