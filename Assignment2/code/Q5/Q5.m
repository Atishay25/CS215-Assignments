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
%imp_vec stores top 84 eigenvectors
imp_vec = zeros(784,84,10);
%max_eig stores the max of eigenvalue for each eigenvector.
max_eig = zeros(1,10);

for i = 1:10
    [vec, eig_vec] = eigs(Cov_mat(:,:,i), 84);
    imp_vec(:,:,i) = vec;
    %showing images using below code.
    if i == 1
        img = data_0(:,1) + mean(:,1);
    elseif i == 2
        img = data_1(:,1) + mean(:,2);
    elseif i == 3
        img = data_2(:,1) + mean(:,3);
    elseif i == 4
        img = data_3(:,1) + mean(:,4);
    elseif i == 5
        img = data_4(:,1) + mean(:,5);
    elseif i == 6
        img = data_5(:,1) + mean(:,6);
    elseif i == 7
        img = data_6(:,1) + mean(:,7);
    elseif i == 8
        img = data_7(:,1) + mean(:,8);
    elseif i == 9
        img = data_8(:,1) + mean(:,9);
    elseif i == 10
        img = data_9(:,1) + mean(:,10);
    end
    image1 = reshape(img, [28,28]);
    image2 = zeros(784,1);
    for p = 1:84
        image2 = image2 + imp_vec(:,p,i)*(dot(img,imp_vec(:,p,i)));
    end
    figure(i);
    subplot(1,2,1), imagesc(uint8(image1))
    xlim tight
    ylim tight
    axis equal;
    title(sprintf('Original'))
    subplot(1,2,2), imagesc(uint8(reshape(image2,[28,28])))
    xlim tight
    ylim tight
    axis equal;
    title(sprintf('Restructured'))
    drawnow;
    
end

