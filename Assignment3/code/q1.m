rng(0)          % setting seed as 0

% Parameters of Gaussian Distributions
sigma_true = 4;
mu_true = 10;
sigma_prior = 1;
mu_prior = 10.5;
M = 125;         % Number of times experiment to be repeated for each N
num_N = 10;      % Number of values of N

errorN_ML = zeros(num_N,M);
errorN_map1 = zeros(num_N,M);
errorN_map2 = zeros(num_N,M);
N_value = zeros(1,num_N);

j = 1;
for N = [5 10 20 40 60 80 100 500 10^3 10^4]
    N_value(1,j) = N;
    for i = 1:M             % Repeating the experiment M times for each N
        data = zeros(N,1);
        for p = 1:N         % Generating sample points from Gaussian
            data(p) = sigma_true.*randn + mu_true;
        end

        % Estimates of Mean calculated from Data sample
        mu_ML = sum(data)/N;
        mu_MAP1 = (mu_ML*(sigma_prior)^2 + (mu_prior*(sigma_true)^2)/N)/((sigma_prior^2) + (sigma_true^2)/N);
        mu_MAP2 = mu_ML;
        if mu_MAP2 < 9.5
            mu_MAP2 = 9.5;
        elseif mu_MAP2 > 11.5
            mu_MAP2 = 11.5;
        end

        % Relative errors in estimates and true value of Mean
        errorN_ML(j,i) = abs(mu_ML - mu_true)/mu_true;
        errorN_map1(j,i) = abs(mu_MAP1 - mu_true)/mu_true;
        errorN_map2(j,i) = abs(mu_MAP2 - mu_true)/mu_true;
    end
    j = j + 1;
end

% Plotting a single Boxplot for Relative errors
% for each N for each Estimate
figure(1);
boxplot(errorN_ML.','Labels',N_value,'Widths',0.2,'Positions',1:numel(N_value));
hold on;
boxplot(errorN_map2.','Labels',N_value,'Widths',0.2,'Positions',(1:numel(N_value))+0.5,'Colors','k');
hold on;
boxplot(errorN_map1.','Labels',N_value,'Widths',0.2,'Positions',(1:numel(N_value))+0.25,'Colors','r');
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'r');       % Setting color of Median line to be Red
plot(NaN,1,'Color','b')
plot(NaN,1,'Color','r')
plot(NaN,1,'Color','k')
legend({'Error in MLE','Error in MAP1','Error in MAP2'})
xlabel('N')
ylabel('Relative Error')
title('Relative Error between True Mean & its Estimates')