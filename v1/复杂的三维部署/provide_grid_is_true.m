%%主程序
clc;
clear ;
format long;
close all;




global N;
global M;
global L;
global W;
global point_num;
global r;
global R;
global count_point;
global rand_point_xyz;
point_num = 1000;
load best_indivi.mat ;
L = 2;% 曲面的长
W = 2;%曲面的宽
%假设1平方米一个网格
M = (L/0.1)*(W/0.1);%网格总数

r = 0.4; %先一种感知半径
R = 2*r;%通信半径
%假设大、中为5，剩下为小
limit = [-1, 1];            % 设置位置参数限制
rand_point_xyz = zeros(3,point_num);%用于存储随机的点
rand_point_x = limit(1,1) + (limit(1,2)-limit(1,1))*rand(1,point_num);
rand_point_y = limit(1,1) + (limit(1,2)-limit(1,1))*rand(1,point_num);

%加入到数组中
 
%更新第三维
for i=1:point_num
    rand_point_xyz(1,i) = rand_point_x(1,i);
    rand_point_xyz(2,i) = rand_point_y(1,i);
    rand_point_xyz(3,i)  = ma_an([rand_point_xyz(1,i),rand_point_xyz(2,i)]);%得更新第三维
end

figure(3);
x_range_point = (-1:0.1:1);%配合画曲面
Dreama_an_grid(x_range_point);
hold on;
%画第一种部署方案
for i=1:point_num
    plot3(rand_point_xyz(1,i), rand_point_xyz(2,i), rand_point_xyz(3,i),'.','MarkerSize',20,'color','r');%画球心 
    hold on;
end

count_point = zeros(1,point_num);%统计被覆盖的次数

%覆盖率
disp(get_Grid_provide(best_indivi,7.73));

           