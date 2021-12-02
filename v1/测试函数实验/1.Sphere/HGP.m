clear;
format long;
clc;
close all;

Exper_num = 20;%��20��ʵ��
Exper_best_fitness_arr = zeros(1,Exper_num);%����ѵ���Ӧֵ
Exper_all_fitness = zeros(Exper_num,30*500);%30��Ⱥ500���������ж�ͳ������ �ɼ�����Ч����
Exper_run_time_arr = zeros(1,Exper_num);%ͳ������ʱ��
Exper_run_success = zeros(1,Exper_num);%ͳ�Ƴɹ��Ĵ��� 1��������ʵ��ɹ��� 0ʧ��
Exper_pop_ave_fitness = zeros(1,Exper_num);%��Ⱥƽ����Ӧֵ
Exper_effect_run = zeros(1,Exper_num);%��Ч��ִ�д�������������
% Exper_best_fitness_ger = zeros(Exper_num,500);%����20��ʵ����ÿ����õ�ֵ

precision = 1*10^-8;%��������

for Exper_index = 1:Exper_num

    disp('��ǰʵ�����');
    disp(Exper_index);
    t1=clock;




    sizepop = 30;%��Ⱥ��ģΪ50
    dimension = 30;%�ռ�ά��Ϊ1
    ger = 500;%����100��
    limit = [-100, 100];%ȡֵ��Χ����
    best_fitness_ger = zeros(1,ger);%��ÿһ������õ�ֵ



    pop_new = zeros(dimension,sizepop);%1��50��
    new_fitness = zeros(1,sizepop);%���µ���Ӧֵ

    %���ù�ͬ�ĳ�ʼ��Ⱥ

    load wolf_pop_public.mat;%���ظ���Ⱥ

    wolf_pop = wolf_pop_public;%�ٸ�����Ⱥ







    wolf_fitness = zeros(1,sizepop);%��һ����Ⱥ����Ӧֵ


    iter = 1;%�ӵ�һ����ʼ
    leader = zeros(dimension,sizepop);%�쵼Ⱥ

    best_indivi = zeros(dimension,1);%����õĸ���
    best_fitness = inf;%��ʼ��Ϊ�����  ����С
    record_fitness = zeros(1,ger);%��¼ÿ������õ���Ӧֵ
    record_aver_pop = zeros(1,ger);%ƽ����Ӧֵ

    %��Ⱥ����

    all_fitness = [];
    all_pos = [];
    while iter <= ger

        %������Ӧֵ

        for i=1:sizepop
            wolf_fitness(1,i) = func(wolf_pop(:,i));
        end
        
        all_fitness = [all_fitness wolf_fitness];
%         all_pos = [all_pos wolf_pop];
        
        %������Сֵ
        [fitness_min,order_index]= min(wolf_fitness);%ͳ���������Ⱥ����õĸ���

        if fitness_min < best_fitness(1,1)
            best_indivi(:,1) = wolf_pop(:,order_index(1,1));%�������Ÿ���
            best_fitness(:,1) = fitness_min;%����������Ӧ
        end
        
%         Exper_best_fitness_ger(Exper_index,iter) = best_fitness;%������õ�ֵ

        record_fitness(1,iter) = best_fitness(1,1);

        record_aver_pop(1,iter) = sum(wolf_fitness)/sizepop;%�ô�����Ⱥ��ƽ����Ӧ��





        %�����õĸ���
        jiyuyun = wolf_pop(:,order_index(1,1));


        %����

        fitness_aver = sum(wolf_fitness)/sizepop;

        %�쵼�߲��� ����������ʣ�����еĽ��б仯
        one_leader = [jiyuyun];

        %�õ�leader
        for i=1:sizepop
            leader(:,i) = one_leader;
        end




        %����
        feng_v_pop =  2*rand(dimension,sizepop)-1;%����




        %�����ٶ�
        qiliu_v_pop =  2*rand(dimension,sizepop)-1;

        %������������
%         a = 1;
%         b = 1;
%         k = 1;
%         %�ѽϳ������仯��10���ȷ�
%         space = 10;
%         every_step = ger/space;
%         ger_half = ger/2;
%         fac = k./(a+b*exp((iter - ger_half)/every_step));



        fac = (1-(iter/ger)^2)^2;

        dis_pop1 = leader(:,(1:1:sizepop/2)) - feng_v_pop(:,(1:1:sizepop/2)).*leader(:,(1:1:sizepop/2)) ;


        pop_new(:,(1:1:sizepop/2)) = leader(:,(1:1:sizepop/2)) - fac*qiliu_v_pop(:,(1:1:sizepop/2)).*dis_pop1;



        dis_pop2 = leader(:,(sizepop/2+1:1:sizepop)) - feng_v_pop(:,(sizepop/2+1:1:sizepop)).*wolf_pop(:,(sizepop/2+1:1:sizepop)) ;


        pop_new(:,(sizepop/2+1:1:sizepop)) = leader(:,(sizepop/2+1:1:sizepop)) - fac*qiliu_v_pop(:,(sizepop/2+1:1:sizepop)).*dis_pop2;

%        pop_new(:,order_index(1,1)) = one_leader;




        %Խ�紦��
        for i=1:sizepop
            for k=1:dimension
                if pop_new(k,i) > limit(1,2) || pop_new(k,i) < limit(1,1)
                    pop_new(k,i) = leader(k,i);
                end
            end
        end

        wolf_pop = pop_new;
        iter = iter + 1;
    end
    
    t2=clock;

    %����
    Exper_best_fitness_arr(1,Exper_index) = best_fitness;
    Exper_all_fitness(Exper_index,:) = all_fitness;
    Exper_run_time_arr(1,Exper_index) = etime(t2,t1);
    Exper_pop_ave_fitness(1,Exper_index) = sum(wolf_fitness)/sizepop;
    
end


%������
disp(['���ֵ:' ,num2str(min(Exper_best_fitness_arr))]);
disp(['���ֵ:' ,num2str(max(Exper_best_fitness_arr))]);
disp(['ƽ��ֵ:' ,num2str(mean(Exper_best_fitness_arr))]);
disp(['��׼��:' ,num2str(std(Exper_best_fitness_arr))]);
disp(['��Ⱥƽ����Ӧֵ:' ,num2str(mean(Exper_pop_ave_fitness))]);
for i=1:Exper_num
    %������Чִ�д���
    index_arr = find(Exper_all_fitness(i,:)==Exper_best_fitness_arr(1,i));
    Exper_effect_run(1,i) = index_arr(1,1);
    
    %����ɹ���
    if Exper_best_fitness_arr(1,i) <= precision
        Exper_run_success(1,i) = 1;
    end
end

disp(['ƽ����Чִ�д���:' ,num2str(mean(Exper_effect_run))]);
disp(['�ɹ���:' ,num2str(mean(Exper_run_success))]);
disp(['ƽ����ʱ:' ,num2str(mean(Exper_run_time_arr))]);



figure(3);
plot(record_fitness);
figure(4);
plot(record_aver_pop);
disp('ȡ����Сֵʱ��λ��Ϊ');
disp(best_indivi);
disp('ȡ�õ���СֵΪ');
disp(best_fitness(1,1));
disp('Խ��Ĵ���');

% figure(6);
% scatter(all_pos(1,:),all_pos(2,:));
% hold on;

%��20��ʵ��ƽ������Ӧֵ������
% HAPOA_aver_fitness = sum(Exper_best_fitness_ger,1)/Exper_num;
% save HAPOA_aver_fitness.mat HAPOA_aver_fitness;


%����20����õ���Ӧֵ ������ͼ
HAPOA_best_fitness = Exper_best_fitness_arr;
save HAPOA_best_fitness.mat  HAPOA_best_fitness ;