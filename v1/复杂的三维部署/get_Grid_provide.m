%%得到覆盖率 
function cover_rate = get_Grid_provide(sensor_mat1,all_sur_area)
    global N;
    global Grid_cen_x_and_y;
    global sur_area_grid;%网格表面积
    global r;
    global L;
    global W;
    global count_point;
    global point_num;
    global rand_point_xyz;
    %被节点覆盖的情况

    for k=1:point_num 
        for j=1:16%节点的数目
            if ((rand_point_xyz(1,k)-sensor_mat1(1,j))^2 + (rand_point_xyz(2,k)-sensor_mat1(2,j))^2+...
                (rand_point_xyz(3,k)-sensor_mat1(3,j))^2) <= r^2
                count_point(1,k) = 1;%代表第(i,j)网格中心点可以被第j个传感器节点覆盖
                
            end
        end
    end


    %%计算联合分布概率  把所有理论上可以覆盖的监测点，重新拿出来做判断，如果
    %任意一个节点使得判断是无障碍物，则可停止，完成覆盖
    true_cover_point = zeros(1,point_num);%统计覆盖
    for k=1:point_num
        for j=1:16
                if count_point(1,k) == 1
                    moni_x_y_z = zeros(1,1,3);
                    moni_x_y_z(1,1,1) = rand_point_xyz(1,k);
                    moni_x_y_z(1,1,2) = rand_point_xyz(2,k);
                    moni_x_y_z(1,1,3) = rand_point_xyz(3,k);
                    zhangaiwu_flag = get_3D_mangqu(sensor_mat1(:,j),moni_x_y_z(1,1,:));
                    if zhangaiwu_flag == 0
                        true_cover_point(1,k) = 1;%真的被覆盖率，
                        break;%停止该监测点的判断
                    end
                end
         end
    end

    
    
    %计算覆盖率 把所有被覆盖的网格 对应的面积相加之和/总面积
    sur_area_sum = sum(true_cover_point);

    disp(sur_area_sum );

    cover_rate = (sur_area_sum/point_num);%覆盖率
end