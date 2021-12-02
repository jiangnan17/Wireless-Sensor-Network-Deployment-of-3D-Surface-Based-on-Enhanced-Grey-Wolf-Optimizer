%%������
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
L = 2;% ����ĳ�
W = 2;%����Ŀ�
%����1ƽ����һ������
M = (L/0.1)*(W/0.1);%��������

r = 0.4; %��һ�ָ�֪�뾶
R = 2*r;%ͨ�Ű뾶




%�������Ϊ5��ʣ��ΪС
N = 50;%30���������ڵ�
sizepop = 50;%��Ⱥ��ģ
dimension = 3;% �ռ�ά��x��y��z
ger = 300;% ����������
pos_limit = [-1, 1];            % ����λ�ò�������
%��������

fix_serson_public = zeros(dimension,6);
fix_serson_public(:,1) = [-0.7;-0.7;0.4];
fix_serson_public(:,2) = [-0.7;0;0.89];
fix_serson_public(:,3) = [-0.7;0.7;0.4];
fix_serson_public(:,4) = [0.7;0.7;0.4];
fix_serson_public(:,5) = [0.7;0;0.89];
fix_serson_public(:,6) = [0.7;-0.7;0.4];

%����
save fix_serson_public.mat fix_serson_public;
fix_serson = fix_serson_public;
fix_serson_index = (N-6+1:1:N);%��6��

%ʵ�����
Exper_num = 1;
Exper_best_fitness_ger = zeros(Exper_num,ger);%����20��ʵ����ÿ����õ�ֵ

for Exper_index = 1:Exper_num
    wolf_pop = zeros(dimension,N,sizepop);

    wolf_pop_temp = zeros(dimension,N,sizepop);%��ʱ��Ⱥ




    %��ʼ����Ⱥ
    for i=1:sizepop
        for j=1:N
            x_pos = rand(1,1)*(pos_limit(1,2) - pos_limit(1,1))+pos_limit(1,1);
            y_pos = rand(1,1)*(pos_limit(1,2) - pos_limit(1,1))+pos_limit(1,1);
            z_pos = ma_an([x_pos,y_pos]);%�����ϵ�z��
            %���뵽��Ⱥ��
            wolf_pop(1,j,i) = x_pos ;
            wolf_pop(2,j,i) = y_pos ;
            wolf_pop(3,j,i) = z_pos ;
        end
        
        %�ѹ̶�ά�ȼ���
        for z = 1:6
            wolf_pop(:,fix_serson_index(1,z),i) = fix_serson(:,z);
        end
        
    end


    wolf_pop_public = wolf_pop;

    save wolf_pop_public.mat wolf_pop_public;%�������Ⱥ


    %����������
    figure(1);
    x_range_point = (-1:0.1:1);%��ϻ�����
    Dreama_an_grid(x_range_point);
    title('��������ɽ��');
    hold on;


    %���³�ʼ���������άͼ  �ɲ鿴��ά
    figure(2);
    x_range_point = (-1:0.1:1);%��ϻ�����
    Dreama_an_grid(x_range_point);
    hold on;
    %����һ�ֲ��𷽰�
    for i=1:N
        draw_ball(r,wolf_pop(1,i,1),wolf_pop(2,i,1),wolf_pop(3,i,1));
        hold on;
    end


    %�鿴��άͼ��
    figure(3);
    x_range_point = (-1:0.1:1);%��ϻ�����
    Dreama_an_grid(x_range_point);
    hold on;
    %����һ�ֲ��𷽰�  ����Ⱥ���еĵ�һ��
    for i=1:N
        plot3(wolf_pop(1,i,1),wolf_pop(2,i,1),wolf_pop(3,i,1),'.','MarkerSize',20,'color','r');%������ 
        hold on;
    end
    hold on;


    %����һ�ݵ�һֻ�ǵ�����
    first_init_public = wolf_pop(:,:,1);
    save first_init_public.mat first_init_public;


end
disp('��ʼ�����');