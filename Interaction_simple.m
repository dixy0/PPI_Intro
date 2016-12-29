% This MATLAB script is to introduce the basic concepts of
% psychophysiological interaction (PPI) of functional MRI (fMRI) data

% Part 1 simple correlation
% Generate simulated variables
x_common = randn(100,1);  % A common signal that give rises to correlation
x_iq = x_common + randn(100,1);  % Simulated IQ
y_volume = x_common + randn(100,1);  % Simulated brain volume

% Plot the relationship and calculate correlation
figure; scatter(x_iq,y_volume,25,'filled');
[r,p] = corr(x_iq,y_volume)


% Part 2 different relationships between two groups
% Generate simulated variables
x_common = randn(100,1);  % A common signal that give rises to correlation
x_iq_male = x_common + randn(100,1);  % Simulated IQ
y_volume_male = x_common + randn(100,1);  % Simulated brain volume
x_iq_female = randn(100,1);  % Simulated IQ
y_volume_female = randn(100,1);  % Simulated brain volume

% concatenate male and female data as whole variables
x_iq = [x_iq_male;x_iq_female];
y_volume = [y_volume_male;y_volume_female];
gender = [ones(100,1);zeros(100,1)];

figure; scatter(x_iq,y_volume,25,gender,'filled');
[r,p] = corr(x_iq,y_volume)
[r_male,p_male] = corr(x_iq_male,y_volume_male)
[r_female,p_female] = corr(x_iq_female,y_volume_female)


% Part3 Different methods to examine correlation differences


