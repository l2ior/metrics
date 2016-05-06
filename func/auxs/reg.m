function yout = reg(y)
% Regulate non-positive values to -1

yout = int8(sign(y(:)));
yout(yout~=1) = -1;
