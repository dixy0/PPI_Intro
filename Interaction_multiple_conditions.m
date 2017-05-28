% This MATLAB script is to introduce the basic concepts of
% psychophysiological interaction (PPI) of functional MRI (fMRI) data
% Author: Xin Di, PhD

clear

% Part 1 correlation differences among three conditions
% There are three conditions: A, B, and R.
% There is only correlation between x1 and x2 in condition A

% Generate simulated variables
x_common = randn(100,1);  % A common signal that give rises to correlation
x1A = x_common + randn(100,1);  % Simulated x1 in condition A
x2A = x_common + randn(100,1);  % Simulated x2 in condition A
x1B = 0.2*x_common + randn(100,1);  % Simulated x1 in condition B
x2B = 0.2*x_common + randn(100,1);  % Simulated x2 in condition B
x1R = randn(100,1);  % Simulated x1 in condition R
x2R = randn(100,1);  % Simulated x2 in condition R

% concatenate variables and generate the psychological variable
x1 = [x1A;x1B;x1R];
x2 = [x2A;x2B;x2R];
psych = [2*ones(100,1);ones(100,1);zeros(100,1)];

figure; scatter(x1,x2,25,psych,'filled');
r = [corr2(x1A,x2A) corr2(x1B,x2B) corr2(x1R,x2R)]


% Part2 Different methods to examine correlation (slope) differences 
psych1 = [ones(100,1);zeros(200,1)];
psych2 = [zeros(100,1);ones(100,1);zeros(100,1)];
design_matrix1 = [[x1A;zeros(200,1)],[zeros(100,1);x1B;zeros(100,1)],[zeros(200,1);x1R],psych1,psych2]; % omitted constant term because regstats will be used
design_matrix2 = [x1,x1.*detrend(psych1,'constant'),x1.*detrend(psych2,'constant'),psych1,psych2];
psych1b = [ones(200,1);zeros(100,1)];
psych2b = [ones(100,1);-ones(100,1);zeros(100,1)];
design_matrix3 = [x1,x1.*detrend(psych1b,'constant'),x1.*detrend(psych2b,'constant'),psych1b,psych2b];

figure; subplot(1,3,1);imagesc(design_matrix1)
subplot(1,3,2);imagesc(design_matrix2)
subplot(1,3,3);imagesc(design_matrix3);colormap('gray')

s = regstats(x2,design_matrix1);
[s.tstat.beta, s.tstat.se, s.tstat.t, s.tstat.pval];
[p,F] = linhyptest(s.beta, s.covb, 0, [0 1 -1 0 0 0], s.tstat.dfe)

s = regstats(x2,design_matrix2);
[s.tstat.beta, s.tstat.se, s.tstat.t, s.tstat.pval];
[p,F] = linhyptest(s.beta, s.covb, 0, [0 0 1 -1 0 0], s.tstat.dfe)

s = regstats(x2,design_matrix3);
[s.tstat.beta, s.tstat.se, s.tstat.t, s.tstat.pval];
[s.tstat.t(4), s.tstat.pval(4)]


