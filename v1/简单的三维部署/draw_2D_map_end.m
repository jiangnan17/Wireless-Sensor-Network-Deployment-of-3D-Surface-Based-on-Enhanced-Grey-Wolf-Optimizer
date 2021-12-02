figure(13);
Grid_cover_unit = draw_init_end_cover(best_indivi);
x_range_point = (-1:0.1:1);%��ϻ�����
Dreama_an_grid(x_range_point);
hold on;
axis([-1,1,-1,1,-1,1]);%����������С�����ֵ 
hold on;
for i=1:N
    plot3(best_indivi(1,i),best_indivi(2,i),best_indivi(3,i),'.','MarkerSize',20,'color','r');%������ 
    hold on;
end
grid on
%�����ǵ�����
for i=1:L/0.1
    for j=1:W/0.1
        if Grid_cover_unit(i,j) == 1 %�ü��㱻����
            plot3(Grid_cen_x_and_y(i,j,1),Grid_cen_x_and_y(i,j,2),Grid_cen_x_and_y(i,j,3),'.','MarkerSize',20,'color','k');%������
            hold on;
        end
    end
end
hold on;


figure(113);
axis([-1,1,-1,1]);%����������С�����ֵ  
set(gca,'xtick',(-1:0.2:1));%����x���경��Ϊ1
set(gca,'ytick',(-1:0.2:1));%����y���경��Ϊ1   ���и����� ����������̫������
axis square;%ʹ���ݱ���Ϊ1  ����Բ����Բ  ��Ȼ����Բ
set(gca,'yminorgrid','on');%��С����
set(gca,'xminorgrid','on');
grid on;%����
hold on;%��ͼһֱ��������
for i=1:N
    plot(best_indivi(1,i),best_indivi(2,i),'.','MarkerSize',20,'color','r');%������ 
    hold on;
end
hold on;

%�����ǵ�
for i=1:L/0.1
    for j=1:W/0.1
        if Grid_cover_unit(i,j) == 1 %�ü��㱻����
            plot(Grid_cen_x_and_y(i,j,1),Grid_cen_x_and_y(i,j,2),'o','MarkerSize',8,'color','k','LineWidth',1);%������
            hold on;
        end
    end
end
hold on;



