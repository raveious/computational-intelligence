function [y] = threehumpcamel(x)
%THREEHUMPCAMEL The Three-hump Camel found at https://www.sfu.ca/~ssurjano/camel3.html
%	Global minimum is at 0.
t1 = 2 * x(1) .^ 2;
t2 = 1.05 * x(1) .^ 4;
t3 = (x(1) .^ 6) / 6;
t4 = x(1) .* x(2);
t5 = x(2) .^ 2;
y = t1 - t2 + t3 + t4 + t5;
end
