rng(1);

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
[V,D] = eig(CovMatrix);
T = realsqrt(D);
E = V*T;


for N = [10 100 1000 10000 100000]
    K = randn(2,N); 
    points = zeros(2,N);
    for i = 1:N
        points(:,i) = mu + E*K(:,i);
    end
    figure(i);
    scatter(points(1,:),points(2,:));
end
        