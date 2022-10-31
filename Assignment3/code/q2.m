rng(0);

N = [5; 10; 20; 40; 60; 80; 100; 500; 10^3; 10^4];
M = 125;
lambda = 5;
alpha = 5.5;
beta = 1;

error_ml = zeros(M*size(N,1),1);
error_pm = zeros(M*size(N,1),1);
N_value = zeros(M*size(N,1),1);

for n = 1:size(N,1)
    for m = 1:M
        data = -0.2.*log(rand(N(n,1),1));
        lambda_ml = N(n,1)./sum(data);
        lambda_pm = (N(n,1) + alpha)./(sum(data) + beta); 
        error_ml(M*(n-1)+m,1) = abs(lambda_ml-lambda)./lambda;
        error_pm(M*(n-1)+m,1) = abs(lambda_pm-lambda)./lambda;
        N_value(M*(n-1)+m,1) = N(n,1);
    end
end

figure(1);
boxplot(error_ml,N_value);
xlabel('N')
ylabel('Error')
title('Boxplot of Error between True lambda & ML Estimate')

figure(2);
boxplot(error_pm,N_value);
xlabel('N')
ylabel('Error')
title('Boxplot of Error between True lambda & Bayesian Estimate')