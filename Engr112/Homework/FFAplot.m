function [ ] = FFAplot(a,b,k)
%FFAplot Plots the FFA curve for 3 different rivers.

% Make sure the length of all inputted vectors are the same.
if length(a) ~= length(b) || length(a) ~= length(k) || length(b) ~= length(k)
    error('All three vectors must have the same length');
end

for river = 1:length(a)
    qValues = zeros(length(a), 1); % Matrix to store magnitudes of floods.
    for T = 1:1:100
        P = 1/T; % [%] Exceedence probability.
        qValues(T) = b(river) + (a(river)/k(river))*(1-(-log(1-P))^k(river));
    end

    % Plot the current river's values over the return period, and hold on
    % for the next rivers.
    loglog(1:100, qValues);
    hold on;
end

hold off;                                % Turn off the hold on the plot.
xlabel('Return period (yr)');            % x-axis label.
ylabel('Flood magnitude (cfs)');         % y-axis label.
legend('River 1', 'River 2', 'River 3'); % Create legend.
grid on;                                 % Turn on gridlines.
