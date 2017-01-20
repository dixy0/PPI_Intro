% This MATLAB script is to introduce the basic concepts of
% psychophysiological interaction (PPI) of functional MRI (fMRI) data
% Author: Xin Di, PhD

% Part 1 simple correlation
% Generate simulated variables
x_common = randn(100,1);  % A common signal that give rises to correlation
x1 = x_common + randn(100,1);  % Simulated IQ
x2 = x_common + randn(100,1);  % Simulated brain volume

% Plot the relationship and calculate correlation
figure; scatter(x1,x2,25,'filled');
xlabel('x1');ylabel('x2');
[r,p] = corr(x1,x2)


% Part 2 different relationships between two groups
% Generate simulated variables
x_common = randn(100,1);  % A common signal that give rises to correlation
x1_conA = x_common + randn(100,1);  % Simulated IQ
x2_conA = x_common + randn(100,1);  % Simulated brain volume
x1_conB = randn(100,1);  % Simulated IQ
x2_conB = randn(100,1);  % Simulated brain volume

% concatenate male and female data as whole variables
x1 = [x1_conA;x1_conB];
x2 = [x2_conA;x2_conB];
condition = [ones(100,1);zeros(100,1)];

figure; scatter(x1,x2,25,condition,'filled');
xlabel('x1');ylabel('x2');
[r,p] = corr(x1,x2)
[r_conA,p_conA] = corr(x1_conA,x2_conA)
[r_conB,p_conB] = corr(x1_conB,x2_conB)


% Part3 Different methods to examine correlation (slope) differences 
design_matrix1 = [[x1_conA;zeros(100,1)],[zeros(100,1);x1_conB],gender]; % omitted constant term because regstats will be used
design_matrix2 = [x1,condition,x1.*condition];

figure; subplot(1,2,1);imagesc(design_matrix1)
subplot(1,2,2);imagesc(design_matrix2);colormap('gray')

s = regstats(x2,design_matrix1);
[s.tstat.beta, s.tstat.se, s.tstat.t, s.tstat.pval];
[p,F] = linhyptest(s.beta, s.covb, 0, [0 1 -1 0], s.tstat.dfe)

s = regstats(x2,design_matrix2);
[s.tstat.t(4), s.tstat.pval(4)]


% Part 4 differences of centering
design_matrix3 = [x1,condition,x1.*detrend(condition,'constant')];

figure; subplot(1,2,1);imagesc(design_matrix2)
subplot(1,2,2);imagesc(design_matrix3);colormap('gray')

figure; subplot(1,3,1);scatter(x1,x2,25,condition,'filled');
subplot(1,3,2);scatter(x1,design_matrix2(:,3), 25,condition,'filled');
subplot(1,3,3);scatter(x1,design_matrix3(:,3), 25,condition,'filled');


s = regstats(x2,design_matrix2);
[s.tstat.t(4), s.tstat.pval(4)]

s = regstats(x2,design_matrix3);
[s.tstat.t(4), s.tstat.pval(4)]

