figure(13);
Grid_cover_unit = draw_init_end_cover(best_indivi);
x_range_point = (-1:0.1:1);%配合画曲面
Dreama_an_grid(x_range_point);
hold on;
axis([-1,1,-1,1,-1,1]);%横纵坐标最小和最大值 
hold on;
for i=1:N
    plot3(best_indivi(1,i),best_indivi(2,i),best_indivi(3,i),'.','MarkerSize',20,'color','r');%画球心 
    hold on;
end
grid on
%画覆盖的区域
for i=1:L/0.1
    for j=1:W/0.1
        if Grid_cover_unit(i,j) == 1 %该监测点被覆盖
            plot3(Grid_cen_x_and_y(i,j,1),Grid_cen_x_and_y(i,j,2),Grid_cen_x_and_y(i,j,3),'.','MarkerSize',20,'color','k');%画球心
            hold on;
        end
    end
end
hold on;


figure(113);
axis([-1,1,-1,1]);%横纵坐标最小和最大值  
set(gca,'xtick',(-1:0.2:1));%设置x坐标步长为1
set(gca,'ytick',(-1:0.2:1));%设置y坐标步长为1   还有个问题 横坐标数字太紧凑了
axis square;%使横纵比例为1  这样圆才像圆  不然像椭圆
set(gca,'yminorgrid','on');%最小网格
set(gca,'xminorgrid','on');
grid on;%网格化
hold on;%把图一直保存起来
for i=1:N
    plot(best_indivi(1,i),best_indivi(2,i),'.','MarkerSize',20,'color','r');%画球心 
    hold on;
end
hold on;

%画覆盖点
for i=1:L/0.1
    for j=1:W/0.1
        if Grid_cover_unit(i,j) == 1 %该监测点被覆盖
            plot(Grid_cen_x_and_y(i,j,1),Grid_cen_x_and_y(i,j,2),'o','MarkerSize',8,'color','k','LineWidth',1);%画球心
            hold on;
        end
    end
end
hold on;



