load("../../data/points2D_Set2.mat")

mean_x = sum(x)/1000;
mean_y = sum(y)/1000;
%the below is the mu vector
mean = [mean_x mean_y];
%it is a 1000*2 matrix which stores points in rows
list = [x y];
%Covariance matrix
Cov = zeros(2,2);
%Calculating covariance matrix
for i = 1:2
    for j = 1:2
        Cov(i,j) = (transpose(list(:,i))*list(:,j))./1000 - mean(i).*mean(j);
    end
end
%the below function yields eigenvector and diagonal eigenvalue matrix.
[vec, eigen] = eig(Cov);
%principal is the eigenvector corresponding to max eigenvalue.
if(eigen(1,1) > eigen(2,2))
    principal = vec(:,1);
else 
    principal = vec(:,2);
end
%plotting the graph.
scatter(x, y,30);
xlim([min(x)-0.5 max(x)+0.5]);
ylim([min(y)-0.5 max(y)+0.5]);
hold on
title('points2D Set2');
xlabel('Sample points of X');
ylabel('Sample points of Y');
%getting the line equation
x_ax = linspace(min(x)-0.5, max(x)+0.5, 200);
y_ax = (x_ax - mean_x).*(principal(2,1)./principal(1,1)) + mean_y;
%plotting the line equation.
plot(x_ax, y_ax);