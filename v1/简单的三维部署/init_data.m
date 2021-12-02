%%主程序
clc;
clear ;
format long;
close all;

delete wolf_pop_public.mat;
delete first_init_public.mat;

global N;
global M;
global L;
global W;
global Grid_cen_x;
global Grid_cen_y;
global Grid_cen_x_and_y;
global sur_area_grid;
global ger;
global r;
global R;
L = 2;% 曲面的长
W = 2;%曲面的宽
%假设1平方米一个网格
M = (L/0.1)*(W/0.1);%网格总数

r = 0.4; %先一种感知半径
R = 2*r;%通信半径




%假设大、中为5，剩下为小
N = 50;%30个传感器节点
sizepop = 50;%种群规模
dimension = 3;% 空间维数x、y，z
ger = 300;% 最大迭代次数
pos_limit = [-1, 1];            % 设置位置参数限制
%个数限制

fix_serson_public = zeros(dimension,6);
fix_serson_public(:,1) = [-0.7;-0.7;0.4];
fix_serson_public(:,2) = [-0.7;0;0.89];
fix_serson_public(:,3) = [-0.7;0.7;0.4];
fix_serson_public(:,4) = [0.7;0.7;0.4];
fix_serson_public(:,5) = [0.7;0;0.89];
fix_serson_public(:,6) = [0.7;-0.7;0.4];

%保存
save fix_serson_public.mat fix_serson_public;
fix_serson = fix_serson_public;
fix_serson_index = (N-6+1:1:N);%共6个

%实验次数
Exper_num = 1;
Exper_best_fitness_ger = zeros(Exper_num,ger);%保存20次实验中每代最好的值

for Exper_index = 1:Exper_num
    wolf_pop = zeros(dimension,N,sizepop);

    wolf_pop_temp = zeros(dimension,N,sizepop);%临时种群




    %初始化种群
    for i=1:sizepop
        for j=1:N
            x_pos = rand(1,1)*(pos_limit(1,2) - pos_limit(1,1))+pos_limit(1,1);
            y_pos = rand(1,1)*(pos_limit(1,2) - pos_limit(1,1))+pos_limit(1,1);
            z_pos = ma_an([x_pos,y_pos]);%曲面上的z轴
            %加入到种群中
            wolf_pop(1,j,i) = x_pos ;
            wolf_pop(2,j,i) = y_pos ;
            wolf_pop(3,j,i) = z_pos ;
        end
        
        %把固定维度加上
        for z = 1:6
            wolf_pop(:,fix_serson_index(1,z),i) = fix_serson(:,z);
        end
        
    end


    wolf_pop_public = wolf_pop;

    save wolf_pop_public.mat wolf_pop_public;%保存该种群


    %画个曲面先
    figure(1);
    x_range_point = (-1:0.1:1);%配合画曲面
    Dreama_an_grid(x_range_point);
    title('马鞍形曲面山坡');
    hold on;


    %画下初始化部署的三维图  可查看二维
    figure(2);
    x_range_point = (-1:0.1:1);%配合画曲面
    Dreama_an_grid(x_range_point);
    hold on;
    %画第一种部署方案
    for i=1:N
        draw_ball(r,wolf_pop(1,i,1),wolf_pop(2,i,1),wolf_pop(3,i,1));
        hold on;
    end


    %查看三维图的
    figure(3);
    x_range_point = (-1:0.1:1);%配合画曲面
    Dreama_an_grid(x_range_point);
    hold on;
    %画第一种部署方案  即种群当中的第一个
    for i=1:N
        plot3(wolf_pop(1,i,1),wolf_pop(2,i,1),wolf_pop(3,i,1),'.','MarkerSize',20,'color','r');%画球心 
        hold on;
    end
    hold on;


    %保存一份第一只狼的数据
    first_init_public = wolf_pop(:,:,1);
    save first_init_public.mat first_init_public;


end
disp('初始化完成');