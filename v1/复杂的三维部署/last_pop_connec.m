for zz =1:sizepop  
    
    best_indivi = wolf_pop(:,:,zz);
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
    draw_MST(best_indivi(1,:),best_indivi(2,:),best_indivi(3,:));
    hold on;

    disp('������');
    disp(get_Grid_cover_unit_and_rate(best_indivi,all_sur_area));
end