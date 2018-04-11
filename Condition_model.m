clear

permn = 100;
for permi = 1:permn
    A = randn(100,1) + 1;
    B = randn(100,1) + randn(1,1);
    
    Data = [A;B];
    
    Psy1 = [ones(100,1),zeros(100,1);zeros(100,1),ones(100,1)];
    Psy2 = [ones(100,1),ones(100,1);zeros(100,1),ones(100,1)];
    
    Beta1 = regress(Data,Psy1);
    Beta1_A(permi,1) = Beta1(1);
    
    Beta2 = regress(Data,Psy2);
    Beta2_A(permi,1) = Beta2(1);
    
    Effect_B(permi,1) = mean(B);
end
