% This MATLAB script is to introduce the basic concepts of
% psychophysiological interaction (PPI) of functional MRI (fMRI) data
% Author: Xin Di, PhD

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


% Part3 Different methods to examine correlation (slope) differences 
design_matrix1 = [[x_iq_male;zeros(100,1)],[zeros(100,1);x_iq_female],gender]; % omitted constant term because regstats will be used
design_matrix2 = [x_iq,gender,x_iq.*gender];

figure; subplot(1,2,1);imagesc(design_matrix1)
subplot(1,2,2);imagesc(design_matrix2);colormap('gray')

s = regstats(y_volume,design_matrix1);
[s.tstat.beta, s.tstat.se, s.tstat.t, s.tstat.pval];
[p,F] = linhyptest(s.beta, s.covb, 0, [0 1 -1 0], s.tstat.dfe)

s = regstats(y_volume,design_matrix2);
[s.tstat.t(4), s.tstat.pval(4)]


% Part 4 differences of centering
design_matrix3 = [x_iq,gender,x_iq.*detrend(gender,'constant')];

figure; subplot(1,2,1);imagesc(design_matrix2)
subplot(1,2,2);imagesc(design_matrix3);colormap('gray')

figure; subplot(1,3,1);scatter(x_iq,y_volume,25,gender,'filled');
subplot(1,3,2);scatter(x_iq,design_matrix2(:,3), 25,gender,'filled');
subplot(1,3,3);scatter(x_iq,design_matrix3(:,3), 25,gender,'filled');


s = regstats(y_volume,design_matrix2);
[s.tstat.t(4), s.tstat.pval(4)]

s = regstats(y_volume,design_matrix3);
[s.tstat.t(4), s.tstat.pval(4)]

