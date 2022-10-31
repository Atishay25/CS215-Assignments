rng(1);         % using 1 as seed

CovMatrix = [1.6250 -1.9486;-1.9486 3.8750];       % Covariance matrix
mu = [1; 2];            % Mean vector

% Calculating A of CovMatrix  = AA^T
[EigenVector,EigenVal] = eig(CovMatrix);
P = realsqrt(EigenVal);
A = EigenVector*P;


for N = [10 100 1000 10000 100000]
    W = randn(2,N); 
    points = zeros(2,N);
    for i = 1:N         % Generating Points
        points(:,i) = mu + A*W(:,i);
    end
    figure(i);
    x = points(1,:);
    y = points(2,:);
    mean_x = sum(x)/N;
    mean_y = sum(y)/N;
    mean_x1 = mean_x.*ones(1,N);
    mean_y1 = mean_y.*ones(1,N);
    mean = [mean_x mean_y];
    list = [x-mean_x1; y-mean_y1];
    Cov_mat = zeros(2,2);
    for i = 1:2
        for j = 1:2
            Cov_mat(i,j) = (list(i,:)*transpose(list(j,:)))./N;
        end
    end
    [vec, eigen] = eig(Cov_mat);
    max_eigen = 0;
    if(eigen(1,1) > eigen(2,2))
        principal = vec(:,1);
        max_eigen = realsqrt(eigen(1,1));
    else 
        principal = vec(:,2);
        max_eigen = realsqrt(eigen(2,2));
    end
    slope = principal(2,1)./principal(1,1);
    scatter(x, y,5);
    mean_vector = [mean_x ; mean_y];
    another_point = mean_vector - max_eigen*principal;
    axis equal;
    hold on
    plot([mean_x another_point(1,1)], [mean_y another_point(2,1)]);
    xlabel('Sample Points of X')
    ylabel('Sample Points of Y')
    legend('Sample Points from 2-D Gaussian')
    title(strcat('Prinipal Modes of Variation for N  = ',{' '}, int2str(N)))
    axis equal;
    drawnow;
end