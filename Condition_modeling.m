clear

x_psy1 = [ones(100,1),zeros(100,1);zeros(100,1),ones(100,1)];
x_psy2 = [ones(100,1),ones(100,1);zeros(100,1),ones(100,1)];

permn = 1000;
for permi = 1:permn
    yA = randn(100,1) + 1;
    yB = randn(100,1) + randn(1);
    
    y = [yA;yB];
    
    Beta1 = regress(y,x_psy1);
    Beta1_A(permi,1) = Beta1(1);
    
    Beta2 = regress(y,x_psy2);
    Beta2_A(permi,1) = Beta2(1);
    
    mean_A(permi,1) = mean(yA);
    mean_B(permi,1) = mean(yB);
end

figure;
subplot(2,3,1); imagesc(x_psy1); colormap('gray'); xticks([1 2]); xticklabels({'A_1','B_1'})
subplot(2,3,2); plot(mean_A,Beta1_A,'.'); xlabel('mean(A)'); ylabel('beta_A_1');
subplot(2,3,3); plot(mean_B,Beta1_A,'.'); xlabel('mean(B)'); ylabel('beta_A_1');
subplot(2,3,4); imagesc(x_psy2); colormap('gray'); xticks([1 2]); xticklabels({'A_2','B_2'})
subplot(2,3,5); plot(mean_A,Beta2_A,'.'); xlabel('mean(A)'); ylabel('beta_A_2');
subplot(2,3,6); plot(mean_B,Beta2_A,'.'); xlabel('mean(B)'); ylabel('beta_A_2');
