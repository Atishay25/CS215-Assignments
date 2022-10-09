N = 10^7;
b = 0.5;
a = 1;
rand_num1 = rand(1,N);
val = tan(2.*pi.*rand_num1);
angle = atan(b.*(val)./a);
for i = 1:N
    c = rand(1,1);
    if(c > 0.25 && c <= 0.5)
        angle(1,i) = pi - angle(1,i);
    elseif(c > 0.5 && c <= 0.75)
        angle(1,i) = pi + angle(1,i);
    elseif(c > 0.75)
        angle(1,i) = -1.*angle(1,i);
    end
end
max_radius = sqrt(1./((sin(angle).*sin(angle))./(b.*b) + (cos(angle).*cos(angle))./(a.*a)));
rand_num2 = rand(1,N);
radius = max_radius.*sqrt(rand_num2);
x = radius.*cos(angle);
y = radius.*sin(angle);
scatter(x, y);