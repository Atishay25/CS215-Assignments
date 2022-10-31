rng(1);         % using 1 as seed

CovMatrix = [1.6250 -1.9486;-1.9486 3.8750];       % Covariance matrix
mu = [1; 2];            % Mean vector

% Calculating A of CovMatrix  = AA^T
[EigenVector,EigenVal] = eig(CovMatrix);
P = realsqrt(EigenVal);
A = EigenVector*P;

error_cov = zeros(1,100,5);
log_N = zeros(1,100,5);         % log(N) scaled
for N = [10 100 1000 10000 100000]
    log_N(:,:,log10(N)) = log10(N).*ones(1,100);
    cov_N = zeros(2,N);
    error = zeros(1,100);
    for p = 1:100
        K = randn(2,N); 
        points = zeros(2,N);
        for i = 1:N         % generating random samples of 2D Gaussian
            points(:,i) = mu + A*K(:,i);
        end
        ML_mu = sum(points,2)/N;
        prod_xy = zeros(1,N);
        for i = 1:N         
            prod_xy(:,i) = points(1,i)*points(2,i); 
        end
        mu_x = ML_mu(1,:);
        mu_y = ML_mu(2,:);
        mu_xy = sum(prod_xy)/N;
        cov_N(:,p) = (mu_xy - (mu_y*mu_x)) - CovMatrix(1,2);
        error(1,p) = norm(cov_N(:,p))/norm(CovMatrix(1,2));     % error in each value
    end
    error_cov(:,:,log10(N)) = error;
end

error_N = reshape(error_cov,[1,500]);
N_matrix = reshape(log_N,[1,500]);
figure;
boxplot(error_N,N_matrix);          % plotting boxplot
xlabel('log(N)')
ylabel('Error')
title('Boxplot of Error between True Covariance & ML Estimate')