clear;
clc;
close all;

Exper_num = 20;%共20次实验
Exper_best_fitness_arr = zeros(1,Exper_num);%存最佳的适应值
Exper_all_fitness = zeros(Exper_num,30*500);%30种群500迭代，所有都统计下来 可计算有效次数
Exper_run_time_arr = zeros(1,Exper_num);%统计运行时间
Exper_run_success = zeros(1,Exper_num);%统计成功的次数 1代表该序号实验成功了 0失败
Exper_pop_ave_fitness = zeros(1,Exper_num);%种群平均适应值
Exper_effect_run = zeros(1,Exper_num);%有效的执行次数，收敛次数
Exper_best_fitness_ger = zeros(Exper_num,500);%保存20次实验中每代最好的值

precision = 1*10^-8;%收敛精度

for Exper_index = 1:Exper_num

    disp('当前实验序号');
    disp(Exper_index);
    t1=clock;
    %删除上次遗留下来的文件
    delete('wolf_pop_public.mat');
    %该函数的x轴限制范围
    sizepop = 30;%种群规模为50
    dimension = 30;%空间维数为1
    ger = 500;%迭代100次
    limit = [-80, 100];%取值范围限制


    wolf_pop = zeros(dimension,sizepop);%2行50列
    best_indivi = zeros(dimension,1);%最优个体   两行一列
    gwo_best_fitness_ger = zeros(1,ger);%保存每代中最佳适应值
    pop_new = zeros(dimension,sizepop);%2行50列
    best_fitness = inf;%先设置最小值

    %初始化种群
    for i=1:sizepop
        wolf_pop(:,i) = limit(1,1) + rand(dimension,1)*(limit(1,2) - limit(1,1));
    end



    wolf_pop_public = wolf_pop;%公共的初始种群

    %保存种群到wolf_pop_public.mat文件中
    save wolf_pop_public.mat wolf_pop_public;


    wolf_fitness = zeros(1,sizepop);%存一个种群的适应值
    wolf_pop_temp = zeros(dimension,sizepop);%临时保存种群
    %最好的三只狼和与之相应的距离
    wolf_one = zeros(dimension,1);
    wolf_one_dis = zeros(dimension,1);
    wolf_two = zeros(dimension,1);
    wolf_two_dis = zeros(dimension,1);
    wolf_three = zeros(dimension,1);
    wolf_three_dis = zeros(dimension,1);
    iter = 1;%从第一代开始

    %种群更新
    all_fitness = [];%保存所有fitness
    
    
    
    
    
    %从这里开始复制
    
    %前三只狼，原来要和之前的一直进行比较
    wolf_one_fitness = inf;
    wolf_two_fitness = inf;
    wolf_three_fitness = inf;
 
    
    while iter <= ger
        
        factor = 2-2*(iter/ger);%随机因子
        
        %计算适应值
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
        
        
        
        
        %保存所有的fitness
        all_fitness = [all_fitness wolf_fitness];


        
        %保存最好的适应值  和 取得最好适应值时的x轴
        if wolf_one_fitness < best_fitness
            best_fitness = wolf_one_fitness;
            best_indivi = wolf_one;
        end
        
        Exper_best_fitness_ger(Exper_index,iter) = best_fitness;%保存最好的值

        gwo_best_fitness_ger(1,iter) = best_fitness;
       
        pop_new = wolf_pop; 
        for i=1:sizepop
            
            %A C 更新
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
            %越界处理  扩充种群的多样性

            %越界处理
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

    %整理
    Exper_best_fitness_arr(1,Exper_index) = best_fitness;
    Exper_all_fitness(Exper_index,:) = all_fitness;
    Exper_run_time_arr(1,Exper_index) = etime(t2,t1);
    Exper_pop_ave_fitness(1,Exper_index) = sum(wolf_fitness)/sizepop;
end


%整理了
disp(['最佳值:' ,num2str(min(Exper_best_fitness_arr))]);
disp(['最差值:' ,num2str(max(Exper_best_fitness_arr))]);
disp(['平均值:' ,num2str(mean(Exper_best_fitness_arr))]);
disp(['标准差:' ,num2str(std(Exper_best_fitness_arr))]);
disp(['种群平均适应值:' ,num2str(mean(Exper_pop_ave_fitness))]);
for i=1:Exper_num
    %计算有效执行次数
    index_arr = find(Exper_all_fitness(i,:)==Exper_best_fitness_arr(1,i));
    Exper_effect_run(1,i) = index_arr(1,1);
    
    %计算成功率
    if Exper_best_fitness_arr(1,i) <= precision
        Exper_run_success(1,i) = 1;
    end
end


disp(['平均有效执行次数:' ,num2str(mean(Exper_effect_run))]);
disp(['成功率:' ,num2str(mean(Exper_run_success))]);
disp(['平均耗时:' ,num2str(mean(Exper_run_time_arr))]);



figure(1);
plot(gwo_best_fitness_ger);
title('历史最好个体适应值');
hold on;


disp('取得最小值时的位置为');
disp(best_indivi);


disp('取得的最小值为');
disp(best_fitness);



%求20次实验平均的适应值并保存
GWO_aver_fitness = sum(Exper_best_fitness_ger,1)/Exper_num;
save GWO_aver_fitness.mat GWO_aver_fitness;


%保存20组最好的适应值 画线形图
GWO_best_fitness = Exper_best_fitness_arr;
save GWO_best_fitness.mat  GWO_best_fitness ;
