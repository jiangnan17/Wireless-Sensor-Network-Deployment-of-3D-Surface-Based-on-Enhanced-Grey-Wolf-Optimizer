clear;
clc;
close all;

Exper_num = 20;%��20��ʵ��
Exper_best_fitness_arr = zeros(1,Exper_num);%����ѵ���Ӧֵ
Exper_all_fitness = zeros(Exper_num,30*500);%30��Ⱥ500���������ж�ͳ������ �ɼ�����Ч����
Exper_run_time_arr = zeros(1,Exper_num);%ͳ������ʱ��
Exper_run_success = zeros(1,Exper_num);%ͳ�Ƴɹ��Ĵ��� 1��������ʵ��ɹ��� 0ʧ��
Exper_pop_ave_fitness = zeros(1,Exper_num);%��Ⱥƽ����Ӧֵ
Exper_effect_run = zeros(1,Exper_num);%��Ч��ִ�д�������������
Exper_best_fitness_ger = zeros(Exper_num,500);%����20��ʵ����ÿ����õ�ֵ

precision = 1*10^-8;%��������

for Exper_index = 1:Exper_num

    disp('��ǰʵ�����');
    disp(Exper_index);
    t1=clock;
    %ɾ���ϴ������������ļ�
    delete('wolf_pop_public.mat');
    %�ú�����x�����Ʒ�Χ
    sizepop = 30;%��Ⱥ��ģΪ50
    dimension = 30;%�ռ�ά��Ϊ1
    ger = 500;%����100��
    limit = [-80, 100];%ȡֵ��Χ����


    wolf_pop = zeros(dimension,sizepop);%2��50��
    best_indivi = zeros(dimension,1);%���Ÿ���   ����һ��
    gwo_best_fitness_ger = zeros(1,ger);%����ÿ���������Ӧֵ
    pop_new = zeros(dimension,sizepop);%2��50��
    best_fitness = inf;%��������Сֵ

    %��ʼ����Ⱥ
    for i=1:sizepop
        wolf_pop(:,i) = limit(1,1) + rand(dimension,1)*(limit(1,2) - limit(1,1));
    end



    wolf_pop_public = wolf_pop;%�����ĳ�ʼ��Ⱥ

    %������Ⱥ��wolf_pop_public.mat�ļ���
    save wolf_pop_public.mat wolf_pop_public;


    wolf_fitness = zeros(1,sizepop);%��һ����Ⱥ����Ӧֵ
    wolf_pop_temp = zeros(dimension,sizepop);%��ʱ������Ⱥ
    %��õ���ֻ�Ǻ���֮��Ӧ�ľ���
    wolf_one = zeros(dimension,1);
    wolf_one_dis = zeros(dimension,1);
    wolf_two = zeros(dimension,1);
    wolf_two_dis = zeros(dimension,1);
    wolf_three = zeros(dimension,1);
    wolf_three_dis = zeros(dimension,1);
    iter = 1;%�ӵ�һ����ʼ

    %��Ⱥ����
    all_fitness = [];%��������fitness
    
    
    
    
    
    %�����￪ʼ����
    
    %ǰ��ֻ�ǣ�ԭ��Ҫ��֮ǰ��һֱ���бȽ�
    wolf_one_fitness = inf;
    wolf_two_fitness = inf;
    wolf_three_fitness = inf;
 
    
    while iter <= ger
        
        factor = 2-2*(iter/ger);%�������
        
        %������Ӧֵ
        for i=1:sizepop
            fitness = func(wolf_pop(:,i));
            wolf_fitness(1,i) = fitness;
            % Update Alpha, Beta, and Delta
            if fitness<wolf_one_fitness 
                wolf_one_fitness=fitness; % Update alpha
                wolf_one=wolf_pop(:,i);
            end

            if fitness>wolf_one_fitness  && fitness<wolf_two_fitness 
                wolf_two_fitness=fitness; % Update beta
                wolf_two=wolf_pop(:,i);
            end

            if fitness>wolf_one_fitness && fitness>wolf_two_fitness && fitness<wolf_three_fitness 
                wolf_three_fitness=fitness; % Update delta
                wolf_three=wolf_pop(:,i);
            end
        end
        
        
        
        
        %�������е�fitness
        all_fitness = [all_fitness wolf_fitness];


        
        %������õ���Ӧֵ  �� ȡ�������Ӧֵʱ��x��
        if wolf_one_fitness < best_fitness
            best_fitness = wolf_one_fitness;
            best_indivi = wolf_one;
        end
        
        Exper_best_fitness_ger(Exper_index,iter) = best_fitness;%������õ�ֵ

        gwo_best_fitness_ger(1,iter) = best_fitness;
       
        pop_new = wolf_pop; 
        for i=1:sizepop
            
            %A C ����
            A1 = 2 * factor * rand(dimension,1) - factor;
            A2 = 2 * factor * rand(dimension,1) - factor;
            A3 = 2 * factor * rand(dimension,1) - factor;

            C1 = 2 * rand(dimension,1);
            C2 = 2 * rand(dimension,1);
            C3 = 2 * rand(dimension,1);
            
            wolf_one_dis =  abs((C1.*wolf_one - wolf_pop(:,i)));
            wolf_two_dis = abs((C2.*wolf_two - wolf_pop(:,i)));
            wolf_three_dis = abs((C3.*wolf_three - wolf_pop(:,i)));

            X1 = wolf_one -  wolf_one_dis .* A1;
            X2 = wolf_two - wolf_two_dis .* A2;
            X3 = wolf_three - wolf_three_dis .* A3;

            pop_new(:,i) = (X1 + X2 + X3)/3;
            %Խ�紦��  ������Ⱥ�Ķ�����

            %Խ�紦��
            for k=1:dimension
                if  (pop_new(k,i) > limit(1,2))|| (pop_new(k,i) < limit(1,1))
                    pop_new(k,i) = limit(1,1) + rand(1,1)*(limit(1,2) - limit(1,1));
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



figure(1);
plot(gwo_best_fitness_ger);
title('��ʷ��ø�����Ӧֵ');
hold on;


disp('ȡ����Сֵʱ��λ��Ϊ');
disp(best_indivi);


disp('ȡ�õ���СֵΪ');
disp(best_fitness);



%��20��ʵ��ƽ������Ӧֵ������
GWO_aver_fitness = sum(Exper_best_fitness_ger,1)/Exper_num;
save GWO_aver_fitness.mat GWO_aver_fitness;


%����20����õ���Ӧֵ ������ͼ
GWO_best_fitness = Exper_best_fitness_arr;
save GWO_best_fitness.mat  GWO_best_fitness ;
