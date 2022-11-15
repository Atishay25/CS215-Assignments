rng(0)          % setting seed as 0

N = [5; 10; 20; 40; 60; 80; 100; 500; 10^3; 10^4];  % Number of data sample points drawn
M = 125;        % Number of times experiment to be repeated for each N
lambda = 5;     % True value of lambda
alpha = 5.5;    % Gamma function parameters
beta = 1;

error_ml = zeros(size(N,1),M);
error_pm = zeros(size(N,1),M);
N_value = zeros(1,size(N,1));

for n = 1:size(N,1)
    for m = 1:M
        data = -0.2.*log(rand(N(n,1),1));       % Generating sample data points
        lambda_ml = N(n,1)./sum(data);          % ML estimate for lambda
        lambda_pm = (N(n,1) + alpha)./(sum(data) + beta);   % Posterior Mean estimate for lambda
        error_ml(n,m) = abs(lambda_ml-lambda)./lambda;      % Relative Errors
        error_pm(n,m) = abs(lambda_pm-lambda)./lambda;
    end
    N_value(1,n) = N(n,1);
end

% Plotting a single Boxplot for Relative errors
% for each N for each Estimate
figure(1);
boxplot(error_ml.','Labels',N_value,'Widths',0.25,'Positions',(1:numel(N_value)));
hold on;
boxplot(error_pm.','Labels',N_value,'Widths',0.25,'Positions',(1:numel(N_value))+0.32,'Colors','k');
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'r');       % Setting color of Median line to be Red
plot(NaN,1,'Color','b')
plot(NaN,1,'Color','k')
legend({'Error in MLE','Error in MPE'})
xlabel('N')
ylabel('Relative Error')
title('Relative Error between \lambda_{true} & its Estimates')