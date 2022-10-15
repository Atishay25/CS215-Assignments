rng(1);         % using 1 as seed

CovMatrix = [1.6250 -1.9486;-1.9486 3.8750];       % Covariance matrix
mu = [1; 2];            % Mean vector

% Calculating A of CovMatrix  = AA^T
[EigenVector,EigenVal] = eig(CovMatrix);
P = realsqrt(EigenVal);
A = EigenVector*P;

for N = [10 100 1000 10000 100000]
    W = randn(2,N);         % Normal random numbers
    points = zeros(2,N);
    for i = 1:N
        points(:,i) = mu + A*W(:,i);
    end
    figure(i);
    scatter(points(1,:),points(2,:));
    xlabel('x')
    ylabel('y')
    title('Sample Points generated from 2-D Gaussian')
end
        