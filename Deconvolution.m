% This MATLAB script is to introduce the basic concepts of
% psychophysiological interaction (PPI) of functional MRI (fMRI) data
% Author: Xin Di, PhD

clear

% Part 1 simple correlation
% Generate simulated variables
N = 300;
n = (0:N-1)';                               % n : discrete-time index

x = randn(N,1)                 % neural signal

% hrf = spm_hrf(2);            % define hemodynamic response function from SPM
hrf = [0;0.0865660809936357;0.374888236471690;0.384923381745461;0.216117315646557;0.0768695652550848;0.00162017719800089;-0.0306078117340448;-0.0373060781329993;-0.0308373715988730;-0.0205161333521205;-0.0116441637490611;-0.00582063147182588;-0.00261854249818620;-0.00107732374408556;-0.000410443522357321;-0.000146257506876445;];

y = conv(hrf, x);
y = y(1:N);                                 % y : output signal (noise-free)

yn = y + 0.2 * randn(N, 1);                 % yn : output signal (noisy)

figure(1)
subplot(2, 1, 1); plot(x); title('Input signal');
subplot(2, 1, 2); plot(hrf); title('Impulse response');

figure(2)
subplot(2, 1, 1); plot(y); title('Output signal');
subplot(2, 1, 2); plot(yn); title('Output signal (noisy)');


% Part 2 deconvolution
H = convmtx(hrf, N);
H = H(1:N, :);                              % H : convolution matrix

% Verify that H*x is the same as y
e = y - H * x;   % should be zero
max(abs(e))

% Direct solve (fails)
g = H \ y;
%  H is singular

% Diagonal loading (noise-free)
lam = 0.1;
g = (H'*H + lam * eye(N)) \ (H' * y);

figure(3)
subplot(2, 1, 1); plot(y); title('Output signal (noise-free)');
subplot(2, 1, 2); plot(g); title(sprintf('Deconvolution (diagonal loading, \\lambda = %.2f)', lam));

% Diagonal loading (noisy)
lam = 0.1;
lam = 1;
g = (H'*H + lam * eye(N)) \ (H' * yn);

figure(4)
subplot(2, 1, 1); plot(yn); title('Output signal (noise-free)');
subplot(2, 1, 2); plot(g); title(sprintf('Deconvolution (diagonal loading, \\lambda = %.2f)', lam));



