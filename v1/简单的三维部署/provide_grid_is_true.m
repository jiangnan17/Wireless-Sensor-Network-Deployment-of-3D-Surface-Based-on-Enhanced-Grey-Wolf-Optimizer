%%������
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
L = 2;% ����ĳ�
W = 2;%����Ŀ�
%����1ƽ����һ������
M = (L/0.1)*(W/0.1);%��������

r = 0.4; %��һ�ָ�֪�뾶
R = 2*r;%ͨ�Ű뾶
%�������Ϊ5��ʣ��ΪС
limit = [-1, 1];            % ����λ�ò�������
rand_point_xyz = zeros(3,point_num);%���ڴ洢����ĵ�
rand_point_x = limit(1,1) + (limit(1,2)-limit(1,1))*rand(1,point_num);
rand_point_y = limit(1,1) + (limit(1,2)-limit(1,1))*rand(1,point_num);

%���뵽������
 
%���µ���ά
for i=1:point_num
    rand_point_xyz(1,i) = rand_point_x(1,i);
    rand_point_xyz(2,i) = rand_point_y(1,i);
    rand_point_xyz(3,i)  = ma_an([rand_point_xyz(1,i),rand_point_xyz(2,i)]);%�ø��µ���ά
end

figure(3);
x_range_point = (-1:0.1:1);%��ϻ�����
Dreama_an_grid(x_range_point);
hold on;
%����һ�ֲ��𷽰�
for i=1:point_num
    plot3(rand_point_xyz(1,i), rand_point_xyz(2,i), rand_point_xyz(3,i),'.','MarkerSize',20,'color','r');%������ 
    hold on;
end

count_point = zeros(1,point_num);%ͳ�Ʊ����ǵĴ���

%������
disp(get_Grid_provide(best_indivi,7.73));

           