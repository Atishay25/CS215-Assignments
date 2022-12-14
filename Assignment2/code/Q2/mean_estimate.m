rng(1);         % using 1 as seed

CovMatrix = [1.6250 -1.9486;-1.9486 3.8750];       % Covariance matrix
mu = [1; 2];            % Mean vector

% Calculating A of CovMatrix  = AA^T
[EigenVector,EigenVal] = eig(CovMatrix);
P = realsqrt(EigenVal);
A = EigenVector*P;

error_N = zeros(1,100,5);
log_N = zeros(1,100,5);
for N = [10 100 1000 10000 100000]
    log_N(:,:,log10(N)) = log10(N).*ones(1,100);
    mu_N = zeros(2,N);
    error = zeros(1,100);
    for p = 1:100           % repeating experiment 100 times for each N
        W = randn(2,N); 
        points = zeros(2,N);
        for i = 1:N
            points(:,i) = mu + A*W(:,i);
        end
        mu_N(:,p) = sum(points,2)/N - mu;   % error in mu
        error(1,p) = norm(mu_N(:,p))/norm(mu);  
    end
    error_N(:,:,log10(N)) = error;
end

error2 = reshape(error_N,[1,500]);
N_matrix = reshape(log_N,[1,500]);
figure;
boxplot(error2,N_matrix);
xlabel('log(N)')
ylabel('Error')
title('Boxplot of Error between True Mean & ML Estimate')
        