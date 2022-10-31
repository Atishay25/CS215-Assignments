rng(0)  % setting seed as 1

sigma_true = 4;
mu_true = 10;
sigma_prior1 = 1;
mu_prior = 10.5;
M = 125;    % Number of times experiment to be repeated
num_N = 10;      % set it to 10

errorN_ML = zeros(M,1,num_N);
errorN_map1 = zeros(M,1,num_N);
errorN_map2 = zeros(M,1,num_N);
N_value = zeros(num_N,1);

j = 1;
for N = [5 10 20 40 60 80 100 500 10^3 10^4]
    N_value(j) = N;
    error_ML = zeros(M,1);
    error_MAP1 = zeros(M,1);
    error_MAP2 = zeros(M,1);
    for i = 1:M
        data = zeros(N,1);
        for p = 1:N
            data(p) = sigma_true.*randn + mu_true;
        end
        mu_ML = sum(data)/N;
        mu_MAP1 = (mu_ML*(sigma_prior1)^2 + (mu_prior*(sigma_true)^2)/N)/((sigma_prior1^2) + (sigma_true^2)/N);
        mu_MAP2 = mu_ML;
        if mu_MAP2 < 9.5
            mu_MAP2 = 9.5;
        elseif mu_MAP2 > 11.5
            mu_MAP2 = 11.5;
        end
        error_ML(i) = abs(mu_ML - mu_true)/mu_true;
        error_MAP1(i) = abs(mu_MAP1 - mu_true)/mu_true;
        error_MAP2(i) = abs(mu_MAP2 - mu_true)/mu_true;
    end
    errorN_ML(:,:,j) = error_ML;
    errorN_map1(:,:,j) = error_MAP1;
    errorN_map2(:,:,j) = error_MAP2;
    j = j + 1;
end

N2 = zeros(M,1, num_N);
for k = 1:num_N
    N2(:,:,k) = N_value(k);
end

err = zeros(M*num_N,1);
err_map1 = zeros(M*num_N,1);
err_map2 = zeros(M*num_N,1);
nnn = zeros(M*num_N,1);
for i = 1:num_N
    k = 1;
    for t = ((i-1)*M + 1):(i*M)
        err(t) = errorN_ML(k,1,i);
        err_map1(t) = errorN_map1(k,1,i);
        err_map2(t) = errorN_map2(k,1,i);
        nnn(t) = N_value(i);
        k  = k + 1;
    end
end

figure(1);
boxplot(err,nnn);
xlabel('N')
ylabel('Error')
title('Boxplot of Error between True Mean & ML Estimate')

figure(2);
boxplot(err_map1,nnn);
xlabel('N')
ylabel('Error')
title('Boxplot of Error between True Mean & MAP1')

figure(3);
boxplot(err_map2,nnn);
xlabel('N')
ylabel('Error')
title('Boxplot of Error between True Mean & MAP2')