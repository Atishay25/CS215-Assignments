load("../../data/mnist.mat");
%mean is the matrix which stores mean vector of digit n in (n+1)th column
mean = zeros(784,10);
%total counts total instances of each digit in given dataset.
total = zeros(1,10);
%converting the int data to floating-point
digits_train = double(digits_train.*1.0);
%reshaping the matrix of 28*28 to 784 dimension.
row_data = reshape(digits_train,[784, 60000]);
% calculating mean of each digit by using label train
for i = 1:60000
    total(1,labels_train(i,1)+1) = total(1,labels_train(i,1)+1) + 1;
    mean(:,labels_train(i,1)+1) = mean(:,labels_train(i,1)+1) + row_data(:,i);
end
for i = 1:10
    mean(:,i) = mean(:,i)./total(1,i);
end
%count will be used to store the image data - corresponding mu in data_n
count = ones(1,10);
%below are matrix with each column having image data
data_0 = zeros(784, total(1,1));
data_1 = zeros(784, total(1,2));
data_2 = zeros(784, total(1,3));
data_3 = zeros(784, total(1,4));
data_4 = zeros(784, total(1,5));
data_5 = zeros(784, total(1,6));
data_6 = zeros(784, total(1,7));
data_7 = zeros(784, total(1,8));
data_8 = zeros(784, total(1,9));
data_9 = zeros(784, total(1,10));
%below code stores the values in the corresponding digit_n
for i = 1:60000
    if labels_train(i,1) == 0
        data_0(:,count(1,1)) = row_data(:,i) - mean(:,1);
        count(1,1) = count(1,1) + 1;
    elseif labels_train(i,1) == 1
        data_1(:,count(1,2)) = row_data(:,i) - mean(:,2);
        count(1,2) = count(1,2) + 1;
    elseif labels_train(i,1) == 2
        data_2(:,count(1,3)) = row_data(:,i) - mean(:,3);
        count(1,3) = count(1,3) + 1;
    elseif labels_train(i,1) == 3
        data_3(:,count(1,4)) = row_data(:,i) - mean(:,4);
        count(1,4) = count(1,4) + 1;
    elseif labels_train(i,1) == 4
        data_4(:,count(1,5)) = row_data(:,i) - mean(:,5);
        count(1,5) = count(1,5) + 1;
    elseif labels_train(i,1) == 5
        data_5(:,count(1,6)) = row_data(:,i) - mean(:,6);
        count(1,6) = count(1,6) + 1;
    elseif labels_train(i,1) == 6
        data_6(:,count(1,7)) = row_data(:,i) - mean(:,7);
        count(1,7) = count(1,7) + 1;
    elseif labels_train(i,1) == 7
        data_7(:,count(1,8)) = row_data(:,i) - mean(:,8);
        count(1,8) = count(1,8) + 1;
    elseif labels_train(i,1) == 8
        data_8(:,count(1,9)) = row_data(:,i) - mean(:,9);
        count(1,9) = count(1,9) + 1;
    elseif labels_train(i,1) == 9
        data_9(:,count(1,10)) = row_data(:,i) - mean(:,10);
        count(1,10) = count(1,10) + 1;
    end
end
%calculating cov matrix by matrix multiplication.
Cov_mat = zeros(784,784,10);
Cov_mat(:,:,1) = data_0*transpose(data_0)./total(1,1);
Cov_mat(:,:,2) = data_1*transpose(data_1)./total(1,2);
Cov_mat(:,:,3) = data_2*transpose(data_2)./total(1,3);
Cov_mat(:,:,4) = data_3*transpose(data_3)./total(1,4);
Cov_mat(:,:,5) = data_4*transpose(data_4)./total(1,5);
Cov_mat(:,:,6) = data_5*transpose(data_5)./total(1,6);
Cov_mat(:,:,7) = data_6*transpose(data_6)./total(1,7);
Cov_mat(:,:,8) = data_7*transpose(data_7)./total(1,8);
Cov_mat(:,:,9) = data_8*transpose(data_8)./total(1,9);
Cov_mat(:,:,10) = data_9*transpose(data_9)./total(1,10);

for p = 1:10
    % getting eigenvectors and eigenvalues in descending order
    [vec, eigval] = eigs(Cov_mat(:,:,p), 784);
    vec = real(vec);
    eigval = real(eigval);
    x_ax = linspace(1,784,784);
    max = 1;
    for j = 2:784
        if(eigval(max,max) < eigval(j,j))
            max = j;
        end
    end
    eig_vec = sort(diag(eigval),'descend');
    max_eig = eigval(max,max);
    principal_vec = vec(:,max);  
    %vector which contains image of principal mode of variation
    shift1 = mean(:,p) - sqrt(max_eig).*principal_vec;
    shift2 = mean(:,p) + sqrt(max_eig).*principal_vec;
    %reshaping the image data to 28*28
    shift1_plot = reshape(shift1,[28,28]);
    shift2_plot = reshape(shift2,[28,28]);   
    mean_plot = reshape(mean(:,p),[28,28]);
    %showing images
    figure(p);
    scatter(x_ax, eig_vec);
    xlim tight
    ylim tight
    title(strcat('Eigenvalue plot of',{' '},int2str(p-1)));
    xlabel('Enumeration');
    ylabel('Eigenvalue');
    figure(p+10);
    subplot(1,3,1), imagesc((mean_plot))
    axis equal;
    xlim tight
    ylim tight
    title(sprintf('mean'))
    subplot(1,3,2), imagesc(shift1_plot)
    axis equal;
    xlim tight
    ylim tight
    title(sprintf('mu - sqrt(lambda)*vec'))
    subplot(1,3,3), imagesc((shift2_plot))
    axis equal;
    xlim tight
    ylim tight
    title(sprintf('mu + sqrt(lambda)*vec'))
    drawnow;
end