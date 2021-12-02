%%得到覆盖率 
function cover_rate = get_Grid_cover_unit_and_rate(sensor_mat1,all_sur_area)
    global N;
    global Grid_cen_x_and_y;
    global sur_area_grid;%网格表面积
    global r;
    global L;
    global W;

    Grid_cover_unit = zeros(L/0.1,W/0.1);%L*W个用于保存2500个网格的联合概率
    Grid_cover_bool = zeros(L/0.1,W/0.1,N);%每个网格中心监测的概率  只能是0或者

    %被节点覆盖的情况
    for i=1:L/0.1
        for j=1:W/0.1
            for k=1:N %节点的数目
                if ((Grid_cen_x_and_y(i,j,1)-sensor_mat1(1,k))^2 + (Grid_cen_x_and_y(i,j,2)-sensor_mat1(2,k))^2+...
                    (Grid_cen_x_and_y(i,j,3)-sensor_mat1(3,k))^2) <= r^2
                    Grid_cover_bool(i,j,k) = 1;%代表第(i,j)网格中心点可以被第j个传感器节点覆盖
                end
            end
        end
    end


    %%计算联合分布概率  把所有理论上可以覆盖的监测点，重新拿出来做判断，如果
    %任意一个节点使得判断是无障碍物，则可停止，完成覆盖
    for i=1:L/0.1
        for j=1:W/0.1
            for k=1:N
                if Grid_cover_bool(i,j,k) == 1
                    zhangaiwu_flag = get_3D_mangqu(sensor_mat1(:,k),Grid_cen_x_and_y(i,j,:));
                    if zhangaiwu_flag == 0
                        Grid_cover_unit(i,j) = 1;%真的被覆盖率，
                        break;%停止该监测点的判断
                    end
                end
            end
        end
    end

    
    
    %计算覆盖率 把所有被覆盖的网格 对应的面积相加之和/总面积
    sur_area_sum = 0;
    for i=1:L/0.1
        for j=1:W/0.1
            if Grid_cover_unit(i,j) == 1 %该监测点被覆盖
                sur_area_sum = sur_area_grid(i,j) + sur_area_sum;
            end
        end
    end


    cover_rate = sur_area_sum/all_sur_area;%覆盖率
end