rng(1);         % using 1 as seed

N = 10^7;       % Numbers to be sampled
e = exp(1);     % e = 2.71 = Napier's constant

a = -1.*(3.*e./(4.*pi));    % Coefficients to solve Quadratic equation
b = 3.*e./2;                % of form ax^2 + bx + c = 0
c = -1.*pi.*e./4;

area = pi.*e./2;             % total area of triangle
rand_num = area.*rand(1,N);  % generating uniform rand numbers and scaling them to area 
                             %  to generate uniform random number for triangle

x = zeros(1,N);     % generating x-coordinate of points
for i = 1:N
    if(rand_num(1,i) < area./3)
        x(1,i) = sqrt(2.*pi.*rand_num(1,i)./(3.*e));
    else
        x(1,i) = (sqrt(b.*b - 4.*a.*(c-rand_num(1,i))) - b)./(2.*a);
    end
end

rand_num2 = rand(1,N);      % generating N uniform random numbers 
y = zeros(1,N);             % y-coordinates
for i = 1:N
    if(x(1,i) < pi./3)
        y(1,i) = 3.*e.*x(1,i)./pi;
    else
        y(1,i) = -1.*3.*e.*(x(1,i) - pi)./(2.*pi);
    end
end
y = y.*rand_num2;

histogram2(x,y,'DisplayStyle','tile');      % Plotting the sampled points
xlabel('x - axis')                          % in 2-D Histogram
ylabel('y - axis')
title('Uniformly Sampled Independent Points in Triangle')

