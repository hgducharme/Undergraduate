% By submitting this assignment, I agree to the following:
% “Aggies do not lie, cheat, or steal, or tolerate those who do”
% “I have not given or received any unauthorized aid on this assignment”
%
% Name: Hunter Ducharme
% Section: 533
% Team: 22
% Assignment: Credit Card Interest
% Date: 22 November 2016
%
%CCINTEREST determines the number of months required to pay off a credit
%card bablance assuming no other purchases are made using the card while the
%debt is being paid.
%   Consider a credit card balance b, some number of months to payoff the
%   balance n, a monthly payment p, and an effective monthly interest rate
%   r, then the number of months needed to payoff the balance is
%   n = -log(1-(rb/p)/log(1+r).

% Constants
CREDIT_CARD_BALANCE = input('Credit card balance ($): ');
ANNUAL_PERCENTAGE_RATE = input('Annual percentage rate (%): ');
EFFECTIVE_INTEREST_RATE = (ANNUAL_PERCENTAGE_RATE/100) / 12;

fprintf('%% \t Months to payoff balance\n');
for i = .01:.01:.25
    monthlyPayment = i * CREDIT_CARD_BALANCE;
    n = -log(1 - (EFFECTIVE_INTEREST_RATE*CREDIT_CARD_BALANCE/monthlyPayment))/log(1+EFFECTIVE_INTEREST_RATE);
    
    if (1-((EFFECTIVE_INTEREST_RATE*CREDIT_CARD_BALANCE)/monthlyPayment)) < 0
        fprintf('%.0f \t N/A: Interest acquires faster than payment.\n', i*100);
    else
        fprintf('%.0f \t %0.1f\n', i*100, n);
    end
end