clear

x_psy1 = [ones(100,1),zeros(100,1);zeros(100,1),ones(100,1)];
x_psy2 = [ones(100,1),ones(100,1);zeros(100,1),ones(100,1)];

permn = 1000;
for permi = 1:permn
    share_A = randn(100,1);
    share_B = randn(100,1) * randn(1);
    
    x_phy = [share_A;share_B] + randn(200,1);
    
    y = [share_A;share_B] + randn(200,1);
    
    glm1 = [x_psy1 x_psy1(:,1).*x_phy x_psy1(:,2).*x_phy];
    
    Beta1 = regress(y,glm1);
    Beta1_PPI_A(permi,1) = Beta1(3);
    
    glm2 = [x_psy2 x_psy2(:,1).*x_phy x_psy2(:,2).*x_phy];
    
    Beta2 = regress(y,glm2);
    Beta2_PPI_A(permi,1) = Beta2(3);
    
    corr_A(permi,1) = corr(x_phy(1:100,1),y(1:100,1));
    corr_B(permi,1) = corr(x_phy(101:end,1),y(101:end,1));
end

figure;
subplot(2,3,1); imagesc(glm1); colormap('gray'); xticks([1 2 3 4]); xticklabels({'A_1','B_1','PPI_A_1','PPI_B_1'})
subplot(2,3,2); plot(corr_A,Beta1_PPI_A,'.k'); xlabel('corr(A)'); ylabel('beta_P_P_I_A_1');
subplot(2,3,3); plot(corr_B,Beta1_PPI_A,'.k'); xlabel('corr(B)'); ylabel('beta_P_P_I_A_1');
subplot(2,3,4); imagesc(glm2); colormap('gray'); xticks([1 2 3 4]); xticklabels({'A_2','B_2','PPI_A_2','PPI_B_2'})
subplot(2,3,5); plot(corr_A,Beta2_PPI_A,'.k'); xlabel('corr(A)'); ylabel('beta_P_P_I_A_2');
subplot(2,3,6); plot(corr_B,Beta2_PPI_A,'.k'); xlabel('corr(B)'); ylabel('beta_P_P_I_A_2');
