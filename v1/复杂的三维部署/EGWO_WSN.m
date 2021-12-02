%%������
clc;
clear ;
format long;
close all;




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
L = 10;% ����ĳ�
W = 10;%����Ŀ�
%����1ƽ����һ������
M = (L/0.5)*(W/0.5);%��������

r = 1; %��һ�ָ�֪�뾶
R = 2*r;%ͨ�Ű뾶
%�������Ϊ5��ʣ��ΪС
N = 100;%30���������ڵ�
sizepop = 50;%��Ⱥ��ģ
dimension = 3;% �ռ�ά��x��y��z
ger = 10;% ����������
limit = [0, 10];            % ����λ�ò�������
%��������

load fix_serson_public.mat;
fix_serson = fix_serson_public;
fix_serson_index = (N-6+1:1:N);%��6��

%ʵ�����
Exper_num = 1;
Exper_best_fitness_ger = zeros(Exper_num,ger);%����20��ʵ����ÿ����õ�ֵ

for Exper_index = 1:Exper_num

    load wolf_pop_public.mat;%���ظ���Ⱥ
    load first_init_public.mat;%���ص�һ������ʼ����
    wolf_pop = wolf_pop_public;


    wolf_pop_temp = zeros(dimension,N,sizepop);%��ʱ��Ⱥ





    %����������
    figure(1);
    x_range_point = (0:0.2:10);%��ϻ�����
    Dreama_an_grid(x_range_point);
    title('��������ɽ��');
    hold on;


    %���³�ʼ���������άͼ  �ɲ鿴��ά
    figure(2);
    x_range_point = (0:0.2:10);%��ϻ�����
    Dreama_an_grid(x_range_point);
    hold on;
    %����һ�ֲ��𷽰�
    for i=1:N
        draw_ball(r,wolf_pop(1,i,1),wolf_pop(2,i,1),wolf_pop(3,i,1));
        hold on;
    end


    %�鿴��άͼ��
    figure(3);
    x_range_point = (0:0.2:10);%��ϻ�����
    Dreama_an_grid(x_range_point);
    hold on;
    %����һ�ֲ��𷽰�
    for i=1:N
        plot3(wolf_pop(1,i,1),wolf_pop(2,i,1),wolf_pop(3,i,1),'.','MarkerSize',20,'color','r');%������ 
        hold on;
    end


    %��������ά�滮��2500������
    %��������������
    X_mat = (0:0.5:10);%x����
    Y_mat = (0:0.5:10);%y����


    %����ÿ������ı����
    sur_area_grid = zeros(L/0.5,W/0.5);%���ڴ�ÿ��С����ı���� ����µ�Ϊ��һ��
    for i=1:L/0.5
        for j=1:W/0.5
            sur_area_grid(i,j) = get_sur_area(X_mat(1,j),X_mat(1,j+1),Y_mat(1,i),Y_mat(1,i+1));
        end
    end

    all_sur_area = sum(sum(sur_area_grid));


    Grid_cen_x = zeros(1,L/0.5);%�������ĵ�x����
    Grid_cen_y = zeros(1,W/0.5);%�������ĵ�y����
    %ǰ���������֮�ͳ���2
    for i=1:L/0.5
        Grid_cen_x(1,i) = (X_mat(i)+X_mat(i+1))/2;
        Grid_cen_y(1,i) = (Y_mat(i)+Y_mat(i+1))/2;
    end

    %����
    %��������һ��Ϊ��һ��
    Grid_cen_x_and_y = zeros(L,W,3);%��L*W���������ģ�����ÿ������������x,y,z
    for i=1:L/0.5
        for j=1:W/0.5
            Grid_cen_x_and_y(i,j,1) = Grid_cen_x(1,j);%1����x
            Grid_cen_x_and_y(i,j,2) = Grid_cen_y(1,i);%��y����ŵ��ڶ���
            Grid_cen_x_and_y(i,j,3) = ma_an([Grid_cen_x_and_y(i,j,1),Grid_cen_x_and_y(i,j,2)]);%��z����ŵ�������
        end
    end

    %������Ⱥ�ĸ�����
    wolf_fitness = zeros(1,sizepop);

    best_fitness = -inf;%������
    record_ger = zeros(1,ger);%ÿ�ε�������õ�fitness
    record_pop_ave = zeros(1,ger);
    wolf_leader_pops = zeros(dimension,N,sizepop);%���ϳ���ά

    %�����㷨����
    iter = 1;
    while iter <= ger

        %�������Ⱥ��ÿ���������Ӧֵ

        %������Ⱥ������
        for i=1:sizepop
            wolf_fitness(1,i) = get_Grid_cover_unit_and_rate(wolf_pop(:,:,i),all_sur_area);
        end

        %�����ʼ����Ӧ�ĸ�����
        if iter == 1
            init_fitness = wolf_fitness(1,1);
        end
        
        [fitness_max,max_index] = max(wolf_fitness);%����Ӧֵ��������
        wolf_leader = wolf_pop(:,:,max_index);%��ͷ��

        for i=1:sizepop
            wolf_leader_pops(:,:,i) = wolf_leader;%������ά
        end


        %������õĵ���Ӧֵ
        if fitness_max > best_fitness
            best_fitness = fitness_max;
            best_indivi = wolf_leader;
        end
        record_ger(1,iter) = best_fitness;%����ô������ŵ���Ӧ��ֵ

        disp(['ʵ�������',num2str(Exper_index)]);
        disp(['����������',num2str(iter)]);
        disp(['��Ѹ����ʣ�',num2str(best_fitness)]);

        sum_fitness = sum(wolf_fitness);
        record_pop_ave(1,iter) = sum_fitness/sizepop;%�������Ⱥ��ƽ����Ӧ��




         %����
        feng_v_pop =  2*rand(dimension,N,sizepop)-1;%����




        %�����ٶ�
        qiliu_v_pop =  2*rand(dimension,N,sizepop)-1;

        %������������
        a = 1;
        b = 1;
        k = 1;
        %�ѽϳ������仯��10���ȷ�
        space = 10;
        every_step = ger/space;
        ger_half = ger/2;
        fac = k./(a+b*exp((iter - ger_half)/every_step));


    %     fac = 1 - (iter/ger);
        %������쵼����Ⱥ�ľ���

        dis_pop1 = wolf_leader_pops - feng_v_pop.*wolf_leader_pops ;


        pop_new = wolf_leader_pops - fac*qiliu_v_pop.*dis_pop1;










        %Խ�紦��
        for i=1:sizepop
            for j=1:dimension-1%����ά�ü���
                for k=1:N
                    if pop_new(j,k,i) > limit(1,2) || pop_new(j,k,i) < limit(1,1)
                        pop_new(j,k,i) = wolf_leader_pops(j,k,i);
    %                     pop_new(3,k,i) = ma_an([pop_new(1,k,i),pop_new(2,k,i)]);%��ʱ�Ȳ����µ���άλ��
                    end
                end
            end
        end


        wolf_pop = wolf_leader_pops;
        
         %�������ڵ�仯λ��
        swap_node_num = 1;
        for i=1:sizepop
            node_index = randperm(N,swap_node_num);
            for k=1:swap_node_num
                wolf_pop(:,node_index(1,k),i) = pop_new(:,node_index(1,k),i);
                wolf_pop(3,node_index(1,k),i) = ma_an([wolf_pop(1,node_index(1,k),i),wolf_pop(2,node_index(1,k),i)]);%�ø��µ���ά
            end
            
            %�ѹ̶�ά�ȼ���
%             for z = 1:6
%                 wolf_pop(:,fix_serson_index(1,z),i) = fix_serson(:,z);
%             end
        end


       


        iter = iter+1;
    end
    clc;
    %��������
    Exper_best_fitness_ger(Exper_index,:) = record_ger;
end


%�����ƽ��ֵ Ȼ�󱣴�
HGP_best_fitness_ger = sum(Exper_best_fitness_ger,1)/Exper_num;
save HGP_best_fitness_ger.mat HGP_best_fitness_ger;


figure(6);
plot(record_ger);
title('ÿ�������ŵ���Ӧֵ')

figure(7);
plot(record_pop_ave);
title('ÿ����Ⱥ��ƽ����Ӧֵ')


%���Ĳ���ͼ
%���³�ʼ���������άͼ  �ɲ鿴��ά
figure(8);
x_range_point = (0:0.2:10);%��ϻ�����
Dreama_an_grid(x_range_point);
hold on;
%����һ�ֲ��𷽰�
for i=1:N
    draw_ball(r,best_indivi(1,i),best_indivi(2,i),best_indivi(3,i));
    hold on;
end


%�鿴��άͼ��
figure(9);
x_range_point = (0:0.2:10);%��ϻ�����
Dreama_an_grid(x_range_point);
hold on;
%����һ�ֲ��𷽰�
for i=1:N
    plot3(best_indivi(1,i),best_indivi(2,i),best_indivi(3,i),'.','MarkerSize',20,'color','r');%������ 
    hold on;
end



disp('������ͨ�Ե��ж�...');
pause(1);
%��ͨ�Ե��ж�
is_connec = get_3D_connection(best_indivi);
if is_connec == 1
    disp('������������ͨ��');
else
    disp('�������粻����ͨ��');
end





%��С�������Ĳ���
figure(10);
x_range_point = (0:0.2:10);%��ϻ�����
Dreama_an_grid(x_range_point);
hold on;
axis([0,10,0,10,-1,1]);%����������С�����ֵ 
hold on;
for i=1:N
    plot3(best_indivi(1,i),best_indivi(2,i),best_indivi(3,i),'.','MarkerSize',20,'color','r');%������ 
    hold on;
end
grid on
draw_MST(best_indivi(1,:),best_indivi(2,:),best_indivi(3,:));
hold on;



figure(11);
axis([0,10,0,10,-1,1]);%����������С�����ֵ 
hold on;
for i=1:N
    plot3(best_indivi(1,i),best_indivi(2,i),best_indivi(3,i),'.','MarkerSize',20,'color','r');%������ 
    hold on;
end
grid on
draw_MST(best_indivi(1,:),best_indivi(2,:),best_indivi(3,:));
hold on;



%���ʼ���ĸ���ͼ
figure(12);
Grid_cover_unit = draw_init_end_cover(first_init_public);
x_range_point = (0:0.2:10);%��ϻ�����
Dreama_an_grid(x_range_point);
hold on;
axis([0,10,0,10,-1,1]);%����������С�����ֵ 
hold on;
for i=1:N
    plot3(first_init_public(1,i),first_init_public(2,i),first_init_public(3,i),'.','MarkerSize',20,'color','r');%������ 
    hold on;
end
grid on
%�����ǵ�����
for i=1:L/0.5
    for j=1:W/0.5
        if Grid_cover_unit(i,j) == 1 %�ü��㱻����
            plot3(Grid_cen_x_and_y(i,j,1),Grid_cen_x_and_y(i,j,2),Grid_cen_x_and_y(i,j,3),'.','MarkerSize',20,'color','k');%������
            hold on;
        end
    end
end
hold on;



%�����յĸ���ͼ
figure(13);
Grid_cover_unit = draw_init_end_cover(best_indivi);
x_range_point = (0:0.2:10);%��ϻ�����
Dreama_an_grid(x_range_point);
hold on;
axis([0,10,0,10,-1,1]);%����������С�����ֵ 
hold on;
for i=1:N
    plot3(best_indivi(1,i),best_indivi(2,i),best_indivi(3,i),'.','MarkerSize',20,'color','r');%������ 
    hold on;
end
grid on
%�����ǵ�����
for i=1:L/0.5
    for j=1:W/0.5
        if Grid_cover_unit(i,j) == 1 %�ü��㱻����
            plot3(Grid_cen_x_and_y(i,j,1),Grid_cen_x_and_y(i,j,2),Grid_cen_x_and_y(i,j,3),'.','MarkerSize',20,'color','k');%������
            hold on;
        end
    end
end
hold on;

save best_indivi.mat best_indivi;

