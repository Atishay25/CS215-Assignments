clear;
clc;
myFolder = "data/data_fruit";
filePattern = fullfile(myFolder, '*.png');
jpegFiles = dir(filePattern);
data = zeros(19200, 16);

for k = 1:length(jpegFiles)
  baseFileName = jpegFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);

  imageArray = imread(fullFileName);
  data(:,k) = reshape(double(imageArray.*1.0),[19200,1]);
  %disp(max(imageArray, [], 'all'));
  figure(k);
  image(double(imageArray)./double(max(imageArray, [], 'all')));  % Display image.
  i = i+1;
  drawnow; % Force display to update immediately.
end
mean = zeros(19200,1);
for i =1:16
    mean = mean + data(:,i);
end
mean = mean./16;
for l = 1:16
    data(:,l) = data(:,l) - mean;
end
mean_img = reshape(mean./(max(mean, [], 'all')),[80,80,3]);


Cov_mat = data*transpose(data)./16;
[Vec, eig_val] = eigs(Cov_mat,10);
eig_vec = diag(eig_val);
x_ax = linspace(1,10,10);
scatter(x_ax,eig_vec);
figure(17);
subplot(1,5,1),image(mean_img);
axis equal;
for m = 1:4
    vec_img = reshape(Vec(:,m)./(max(Vec(:,m), [], 'all')),[80,80,3]);
    subplot(1,5,m+1),image(vec_img);
    axis equal
    drawnow;
end
for n = 1:16
    image1 = zeros(19200,1);
    for p = 1:4
        image1 = image1 + dot(data(:,n),Vec(:,p)).*Vec(:,p);
    end
    figure(n+17);
    image1 = image1 + mean;
    subplot(1,2,1),image(reshape((data(:,n) + mean)./(max(data(:,n) + mean, [], 'all')),[80,80,3]))
    axis equal;
    subplot(1,2,2),image(reshape((image1)./(max(image1, [], 'all')),[80,80,3]))
    axis equal;
end
%using uniformly generated numbers for perturbation.
uni = rand(1,12);
for o = 1:3
    new_img = mean + uni(1,(o-1)*4+1).*sqrt(eig_vec(1,1)).*Vec(:,1) + uni(1,(o-1)*4+2).*sqrt(eig_vec(2,1)).*Vec(:,2) + uni(1,(o-1)*4+3).*sqrt(eig_vec(3,1)).*Vec(:,3) + uni(1,(o-1)*4+4).*sqrt(eig_vec(4,1)).*Vec(:,4); 
    new_img_plt = reshape(new_img./(max(new_img,[],"all")), [80,80,3]);
    figure(33+o);
    image(new_img_plt);
    axis equal;
    title(sprintf(strcat('new image ',int2str(o))));
    drawnow;
end

