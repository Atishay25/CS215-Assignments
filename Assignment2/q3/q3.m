load("data/points2D_Set1.mat")
%len_x = size(x);
mean_x = sum(x)/300;
mean_y = sum(y)/300;
mean = [mean_x mean_y];
list = [x y];
Cov_mat = zeros(2,2);
for i = 1:2
    for j = 1:2
        Cov_mat(i,j) = (transpose(list(:,i))*list(:,j))./300 - mean(i).*mean(j);
    end
end
[vec, eigen] = eig(Cov_mat);
if(eigen(1,1) > eigen(2,2))
    principal = vec(:,1);
else 
    principal = vec(:,2);
end
scatter(x, y,5);
hold on
x_ax = linspace(min(x), max(x), 200);
y_ax = (x_ax - mean_x).*(principal(2,1)./principal(1,1)) + mean_y;
plot(x_ax, y_ax);
