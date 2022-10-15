rng(1);         % seed used as 1

N = 10^7;       % Number of independent points
b = 0.5;        % Minor axis of ellipse
a = 1;          % Major axis of ellipse

rand_num1 = rand(1,N);          % random number between 0 to 1 for angle theta
val = tan(2.*pi.*rand_num1);    % value of CDF function of angle at random number
angle = atan(b.*(val)./a);      % angle theta using inverse CDF of it
for i = 1:N          % Since angle generated is from -pi/2 to pi/2
    c = rand(1,1);   % adding pi to it for half of its instances
    if(c <= 0.5)     % to cover all angles from 0 to 2pi using a random number
        angle(1,i) = pi + angle(1,i);
    end
end

max_radius = sqrt(1./((sin(angle).*sin(angle))./(b.*b) + (cos(angle).*cos(angle))./(a.*a)));
rand_num2 = rand(1,N);            % random number between 0 to 1 for R of point sampled
radius = max_radius.*sqrt(rand_num2);   % calculating R using its inverse CDF

x = radius.*cos(angle);         % x coordinate of sampled point
y = radius.*sin(angle);         % y coordinate of sampled point

histogram2(x,y,'DisplayStyle','tile')   % Plotting 2-D histogram
xlabel('x - axis')
ylabel('y - axis')
title('Uniformly Sampled Independent Points in Ellipse')