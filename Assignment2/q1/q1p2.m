N = 10^7;
e = exp(1);
l = -1.*(3.*e./(4.*pi));
m = 3.*e./2;
n = -1.*pi.*e./4;
area = pi.*e./2;
rand_num = area.*rand(1,N);

x = zeros(1,N);
for i = 1:N
    if(rand_num(1,i) < area./3)
        x(1,i) = sqrt(2.*pi.*rand_num(1,i)./(3.*e));
    else
        %disp(1);
        x(1,i) = (sqrt(m.*m - 4.*l.*(n-rand_num(1,i))) - m)./(2.*l);
    end
end
rand_num2 = rand(1,N);
y = zeros(1,N);
for i = 1:N
    if(x(1,i) < pi./3)
        y(1,i) = 3.*e.*x(1,i)./pi;
    else
        y(1,i) = -1.*3.*e.*(x(1,i) - pi)./(2.*pi);
    end
end
y = y.*rand_num2;
scatter(x,y,1);
