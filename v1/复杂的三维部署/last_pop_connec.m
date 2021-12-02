for zz =1:sizepop  
    
    best_indivi = wolf_pop(:,:,zz);
    disp('进入连通性的判断...');
    pause(1);
    %连通性的判断
    is_connec = get_3D_connection(best_indivi);
    if is_connec == 1
        disp('整个网络是连通的');
    else
        disp('整个网络不是连通的');
    end





    %最小生出树的产生
    figure(10);
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
    draw_MST(best_indivi(1,:),best_indivi(2,:),best_indivi(3,:));
    hold on;

    disp('覆盖率');
    disp(get_Grid_cover_unit_and_rate(best_indivi,all_sur_area));
end