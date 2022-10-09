CovMatrix = [1.6250 -1.9486;-1.9486 3.8750];
%disp(CovMatrix);
mu = [1; 2];
%disp(mu);
% syms a b c
% eqns = [a^2 + b^2 == CovMatrix(1,1), a*c == CovMatrix(1,2), c^2 == CovMatrix(2,2)];
% vars = [a b c];
% [sola, solb, solc] = solve(eqns,vars);
% disp(solc)

c = sqrt(CovMatrix(2,2));
a = CovMatrix(1,2)/c;
b = sqrt(CovMatrix(1,1) - a*a);
d = 0;
A = [a b; c d];
% disp(A);
% C = transpose(A);
% disp(A*C);
j = 1;
error1 = zeros(1,100,5);
N1 = zeros(1,100,5);
for N = [10 100 1000 10000 100000]
    N1(:,:,j) = log10(N).*ones(1,100);
    mu_N = zeros(2,N);
    error = zeros(1,100);
    for p = 1:100
        K = randn(2,N); 
        points = zeros(2,N);
        for i = 1:N
            points(:,i) = mu + A*K(:,i);
        end
        %disp(points)
        mu_p = sum(points,2)/N;
        
        %disp(mu_p);
        mu_N(:,p) = mu_p - mu;
        %disp(mu_N(:,p));
        error(1,p) = norm(mu_N(:,p))/norm(mu);
        %figure(i);
        %scatter(points(1,:),points(2,:));
    end
    %disp(error);
    error1(:,:,j) = error;
    disp(j);
    %subplot(1,5,j),boxplot(error)
    j = j + 1;
    %title('Miles per Gallon by Vehicle Origin')
    %xlabel('Country of Origin')
    %ylabel('Miles per Gallon (MPG)')
end

error2 = reshape(error1,[1,500]);
N2 = reshape(N1,[1,500]);
figure;
boxplot(error2,N2);
        