%%�õ������� 
function cover_rate = get_Grid_provide(sensor_mat1,all_sur_area)
    global N;
    global Grid_cen_x_and_y;
    global sur_area_grid;%��������
    global r;
    global L;
    global W;
    global count_point;
    global point_num;
    global rand_point_xyz;
    %���ڵ㸲�ǵ����

    for k=1:point_num 
        for j=1:16%�ڵ����Ŀ
            if ((rand_point_xyz(1,k)-sensor_mat1(1,j))^2 + (rand_point_xyz(2,k)-sensor_mat1(2,j))^2+...
                (rand_point_xyz(3,k)-sensor_mat1(3,j))^2) <= r^2
                count_point(1,k) = 1;%�����(i,j)�������ĵ���Ա���j���������ڵ㸲��
                
            end
        end
    end


    %%�������Ϸֲ�����  �����������Ͽ��Ը��ǵļ��㣬�����ó������жϣ����
    %����һ���ڵ�ʹ���ж������ϰ�����ֹͣ����ɸ���
    true_cover_point = zeros(1,point_num);%ͳ�Ƹ���
    for k=1:point_num
        for j=1:16
                if count_point(1,k) == 1
                    moni_x_y_z = zeros(1,1,3);
                    moni_x_y_z(1,1,1) = rand_point_xyz(1,k);
                    moni_x_y_z(1,1,2) = rand_point_xyz(2,k);
                    moni_x_y_z(1,1,3) = rand_point_xyz(3,k);
                    zhangaiwu_flag = get_3D_mangqu(sensor_mat1(:,j),moni_x_y_z(1,1,:));
                    if zhangaiwu_flag == 0
                        true_cover_point(1,k) = 1;%��ı������ʣ�
                        break;%ֹͣ�ü�����ж�
                    end
                end
         end
    end

    
    
    %���㸲���� �����б����ǵ����� ��Ӧ��������֮��/�����
    sur_area_sum = sum(true_cover_point);

    disp(sur_area_sum );

    cover_rate = (sur_area_sum/point_num);%������
end