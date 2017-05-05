clc; clear; close;

temperatures = csvread('temperatures.csv');
temperatures2 = csvread('temperatures2.csv');

pressures = (1/1000)*csvread('pressures.csv');
pressures2 = (1/1000)*csvread('pressures2.csv');

enthalpies = zeros(length(temperatures), 1);
entropies = zeros(length(temperatures), 1);
specificVolumes = zeros(length(temperatures), 1);

entropies2 = zeros(length(temperatures2), 1);
specificVolumes2 = zeros(length(temperatures2), 1);

absoluteEntropy = zeros(1, length(temperatures));
absoluteEntropy(1) = [0];
changeInEntropy = zeros(1, length(temperatures)-1);

% Populate change in entropies for 1st case
for i = 2:length(temperatures)
    [t,h,u,s,pr,vr] = thermodynamicInterpolator(temperatures(i-1));
    [t2,h2,u2,s2,pr2,vr2] = thermodynamicInterpolator(temperatures(i));
    
   changeInEntropy(i) = (s2-s) - (8.314/28.97)*log(pressures(i)/pressures(i-1));
end

% Calculate absolute entropy for 1st case
for i = 2:length(changeInEntropy)
    absoluteEntropy(i) = absoluteEntropy(i-1) + changeInEntropy(i);
end

for i = 1:length(temperatures2)
    if i<= length(temperatures)
        [t,h,u,s,pr,vr] = thermodynamicInterpolator(temperatures(i));
        specificVolumes(i) = (8314/28.97)*(temperatures(i))/(pressures(i)*1000);
        entropies(i) = s;
        enthalpies(i) = h;
    end
    
    
        [t2,h2,u2,s2,pr2,vr2] = thermodynamicInterpolator(temperatures2(i));
        entropies2(i) = s2;
        specificVolumes2(i) = (8314/28.97)*(temperatures2(i))/(pressures2(i)*1000);
   
end


labels1 = cellstr( num2str([1:21]') );
labels2 = cellstr( num2str([1:22]') );
figure()
subplot(1, 2, 1); plot(entropies(1:end-1), temperatures(1:end-1), '-k', 'displayName', 'No afterburner'); hold on;
text(entropies(1:end-1), temperatures(1:end-1), labels1, 'VerticalAlignment','top', ...
                              'HorizontalAlignment','left')
subplot(1, 2, 1); plot(entropies(end-1), temperatures(end-1), '-k', 'displayName', 'No afterburner'); hold on;
subplot(1, 2, 1); plot(entropies2(1:end-1), temperatures2(1:end-1), '--.k', 'displayName', 'Afterburner'); hold off;
text(entropies2(1:end-1), temperatures2(1:end-1), labels2, 'VerticalAlignment','top', ...
                             'HorizontalAlignment','left')
axis square;
title('T-s Diagram');
ylabel('Temperature (K)');
xlabel('Entropy (kJ/kg*K)');
legend('show', 'location', 'best');
subplot(1, 2,2); plot(specificVolumes(1:end-1), pressures(1:end-1), '-k', 'displayName', 'No afterburner'); hold on;
text(specificVolumes(1:end-1), pressures(1:end-1), labels1, 'VerticalAlignment','bottom', ...
                              'HorizontalAlignment','center')
subplot(1, 2,2); plot(specificVolumes(end-2:end-1), pressures(end-2:end-1), '-k', 'displayName', 'No afterburner');
subplot(1, 2,2); plot(specificVolumes2(1:end-1), pressures2(1:end-1), '--.k', 'displayName', 'Afterburner'); hold off;
text(specificVolumes2(1:end-1), pressures2(1:end-1), labels2, 'VerticalAlignment','bottom', ...
                             'HorizontalAlignment','center')
axis square;
title('P-v Diagram');
ylabel('Pressure (kPa)');
xlabel('Specific Volume (kg/m^3)');
legend('show', 'location', 'best');