rng(0);

%loading the image data
myFolder = "../../data/data_fruit";

filePattern = fullfile(myFolder, '*.png');
jpegFiles = dir(filePattern);
data = zeros(19200, 16);
%storing the image data in teh matrix data.
for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);

  imageArray = imread(fullFileName);
  data(:,k) = reshape(double(imageArray.*1.0),[19200,1]);
end
%calculating mean
mean = zeros(19200,1);
for i =1:16
    mean = mean + data(:,i);
end
mean = mean./16;
%substracting mean from each data to calculate covariance matrix.
for l = 1:16
    data(:,l) = data(:,l) - mean;
end
%reshaping the mean vector to reconstruct mean image
mean_img = reshape(mean./(max(mean, [], 'all')),[80,80,3]);
%calculating covariance matrix
Cov_mat = data*transpose(data)./16;
%getting eigenvectors and eigenvalues in descending values.
[Vec, eig_val] = eigs(Cov_mat,10);
eig_vec = diag(eig_val);
%plotting the scatter plot of top 10 eigenvalues
x_ax = linspace(1,10,10);
figure(21);
scatter(x_ax,eig_vec,'filled');
title('Eigenvalue Graph');
xlabel('Enumeration');
ylabel('EigenValues');
%drawing images of mean image, and top 4 eigenvector image
figure(1);
subplot(1,5,1),image(mean_img);
xlim tight;
ylim tight;
title(sprintf('mu'))
axis equal;
for m = 1:4
    vec_img = reshape(Vec(:,m)./(max(Vec(:,m), [], 'all')),[80,80,3]);
    subplot(1,5,m+1),image(vec_img);
    xlim tight;
    ylim tight;
    title(sprintf(strcat('v',int2str(m))))
    axis equal
end
drawnow;
%drawing original image and closest representative image.
for n = 1:16
    image1 = zeros(19200,1);
    for p = 1:4
        image1 = image1 + dot(data(:,n),Vec(:,p)).*Vec(:,p);
    end
    figure(n+1);
    image1 = image1 + mean;
    subplot(1,2,1),image(reshape((data(:,n) + mean)./(max(data(:,n) + mean, [], 'all')),[80,80,3]))
    axis equal;
    title(sprintf('Original Image'))
    xlim tight;
    ylim tight;

    subplot(1,2,2),image(reshape((image1)./(max(image1, [], 'all')),[80,80,3]))
    axis equal;
    title(sprintf('Closest Representative Image'))
    xlim tight;
    ylim tight;

end
%using uniformly generated numbers for perturbation around mean using top 4 eigenvectors.
for o = 1:3
    uni = randn(1,4);
    new_img = mean + uni(1,1).*realsqrt(eig_vec(1,1)).*Vec(:,1) + uni(1,2).*realsqrt(eig_vec(2,1)).*Vec(:,2) + uni(1,3).*realsqrt(eig_vec(3,1)).*Vec(:,3) + uni(1,4).*realsqrt(eig_vec(4,1)).*Vec(:,4); 
    new_img_plt = reshape(new_img./(max(new_img,[],"all")), [80,80,3]);
    figure(17+o);
    image(new_img_plt);
    axis equal;
    xlim tight;
    ylim tight;

    title(sprintf(strcat('New Representative Image ',int2str(o))));
    drawnow;
end

