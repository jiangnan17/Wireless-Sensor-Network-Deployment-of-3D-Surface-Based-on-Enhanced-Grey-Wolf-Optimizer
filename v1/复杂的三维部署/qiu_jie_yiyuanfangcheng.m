clc;
clear;
% f = @(x)x.^2-5*x+6;      %注意函数的书写格式
% z0 = [-10,10];
% options = optimset('Display','off'); % Turn off display
% 
% z = fsolve(f,z0,options);
% disp(z);

f = @(x) (x - x_lower)*(z_lower - z_upper)/(x_lower - x_upper) + z_lower - ...
    x.^2 + ((x - x_lower)*(y_lower - y_upper)/(x_lower - x_upper) + y_lower).^2;