clear;
format long;
clc;
close all;

Exper_num = 20;%共20次实验
Exper_best_fitness_arr = zeros(1,Exper_num);%存最佳的适应值
Exper_all_fitness = zeros(Exper_num,30*500);%30种群500迭代，所有都统计下来 可计算有效次数
Exper_run_time_arr = zeros(1,Exper_num);%统计运行时间
Exper_run_success = zeros(1,Exper_num);%统计成功的次数 1代表该序号实验成功了 0失败
Exper_pop_ave_fitness = zeros(1,Exper_num);%种群平均适应值
Exper_effect_run = zeros(1,Exper_num);%有效的执行次数，收敛次数
% Exper_best_fitness_ger = zeros(Exper_num,500);%保存20次实验中每代最好的值

precision = 1*10^-8;%收敛精度

for Exper_index = 1:Exper_num

    disp('当前实验序号');
    disp(Exper_index);
    t1=clock;




    sizepop = 30;%种群规模为50
    dimension = 30;%空间维数为1
    ger = 500;%迭代100次
    limit = [-100, 100];%取值范围限制
    best_fitness_ger = zeros(1,ger);%放每一代中最好的值



    pop_new = zeros(dimension,sizepop);%1行50列
    new_fitness = zeros(1,sizepop);%存新的适应值

    %利用共同的初始种群

    load wolf_pop_public.mat;%加载该种群

    wolf_pop = wolf_pop_public;%再给该种群







    wolf_fitness = zeros(1,sizepop);%存一个种群的适应值


    iter = 1;%从第一代开始
    leader = zeros(dimension,sizepop);%领导群

    best_indivi = zeros(dimension,1);%存最好的个体
    best_fitness = inf;%初始化为无穷大  求最小
    record_fitness = zeros(1,ger);%记录每代中最好的适应值
    record_aver_pop = zeros(1,ger);%平均适应值

    %种群更新

    all_fitness = [];
    all_pos = [];
    while iter <= ger

        %计算适应值

        for i=1:sizepop
            wolf_fitness(1,i) = func(wolf_pop(:,i));
        end
        
        all_fitness = [all_fitness wolf_fitness];
%         all_pos = [all_pos wolf_pop];
        
        %保存最小值
        [fitness_min,order_index]= min(wolf_fitness);%统计这代中种群中最好的个体

        if fitness_min < best_fitness(1,1)
            best_indivi(:,1) = wolf_pop(:,order_index(1,1));%保存最优个体
            best_fitness(:,1) = fitness_min;%保存最优适应
        end
        
%         Exper_best_fitness_ger(Exper_index,iter) = best_fitness;%保存最好的值

        record_fitness(1,iter) = best_fitness(1,1);

        record_aver_pop(1,iter) = sum(wolf_fitness)/sizepop;%该代中种群的平均适应度





        %求得最好的个体
        jiyuyun = wolf_pop(:,order_index(1,1));


        %更新

        fitness_aver = sum(wolf_fitness)/sizepop;

        %领导者策略 用三个引领剩下所有的进行变化
        one_leader = [jiyuyun];

        %得到leader
        for i=1:sizepop
            leader(:,i) = one_leader;
        end




        %风速
        feng_v_pop =  2*rand(dimension,sizepop)-1;%风速




        %气流速度
        qiliu_v_pop =  2*rand(dimension,sizepop)-1;

        %更新收敛因子
%         a = 1;
%         b = 1;
%         k = 1;
%         %把较长的区间化成10个等分
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




        %越界处理
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



figure(3);
plot(record_fitness);
figure(4);
plot(record_aver_pop);
disp('取得最小值时的位置为');
disp(best_indivi);
disp('取得的最小值为');
disp(best_fitness(1,1));
disp('越界的次数');

% figure(6);
% scatter(all_pos(1,:),all_pos(2,:));
% hold on;

%求20次实验平均的适应值并保存
% HAPOA_aver_fitness = sum(Exper_best_fitness_ger,1)/Exper_num;
% save HAPOA_aver_fitness.mat HAPOA_aver_fitness;


%保存20组最好的适应值 画线形图
HAPOA_best_fitness = Exper_best_fitness_arr;
save HAPOA_best_fitness.mat  HAPOA_best_fitness ;