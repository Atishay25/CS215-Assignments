rng(1);

CovMatrix = [1.6250 -1.9486;-1.9486 3.8750];
mu = [1; 2];

[EigenVector,EigenVal] = eig(CovMatrix);
P = realsqrt(EigenVal);
A = EigenVector*P;


for N = [10 100 1000 10000 100000]
    W = randn(2,N); 
    points = zeros(2,N);
    for i = 1:N
        points(:,i) = mu + A*W(:,i);
    end
    figure(i);
    %scatter(points(1,:),points(2,:));
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
    %disp(Cov_mat);
    [vec, eigen] = eig(Cov_mat);
    disp(eigen);
    max_eigen = 0;
    if(eigen(1,1) > eigen(2,2))
        principal = vec(:,1);
        max_eigen = realsqrt(eigen(1,1));
    else 
        principal = vec(:,2);
        max_eigen = realsqrt(eigen(2,2));
    end
    slope = principal(2,1)./principal(1,1);
    x1 = mean_x + max_eigen./(realsqrt(1 + slope*slope));
    y1 = mean_y + (slope.*max_eigen)./(realsqrt(1 + slope*slope));
    scatter(x, y,5);
    mean_vector = [mean_x ; mean_y];
    another_point = mean_vector - max_eigen*principal;
    axis equal;
    hold on
    x_ax = linspace(mean_x, x1, 200);
    y_ax = (x_ax - mean_x).*(slope) + mean_y;
    x_axm = linspace(min(x), max(x), 200);
    y_axm = (x_axm - mean_x).*(slope) + mean_y;
    plot(x_axm, y_axm, '--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.2]);
    plot(x_ax, y_ax, '--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor',[0.5,0.5,0.2]);
    plot([mean_x another_point(1,1)], [mean_y another_point(2,1)]);
    axis equal;
    drawnow;
end