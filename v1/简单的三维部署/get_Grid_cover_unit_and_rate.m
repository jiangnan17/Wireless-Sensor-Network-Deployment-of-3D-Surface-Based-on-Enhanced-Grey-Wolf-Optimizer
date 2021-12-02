%%�õ������� 
function cover_rate = get_Grid_cover_unit_and_rate(sensor_mat1,all_sur_area)
    global N;
    global Grid_cen_x_and_y;
    global sur_area_grid;%��������
    global r;
    global L;
    global W;

    Grid_cover_unit = zeros(L/0.1,W/0.1);%L*W�����ڱ���2500����������ϸ���
    Grid_cover_bool = zeros(L/0.1,W/0.1,N);%ÿ���������ļ��ĸ���  ֻ����0����

    %���ڵ㸲�ǵ����
    for i=1:L/0.1
        for j=1:W/0.1
            for k=1:N %�ڵ����Ŀ
                if ((Grid_cen_x_and_y(i,j,1)-sensor_mat1(1,k))^2 + (Grid_cen_x_and_y(i,j,2)-sensor_mat1(2,k))^2+...
                    (Grid_cen_x_and_y(i,j,3)-sensor_mat1(3,k))^2) <= r^2
                    Grid_cover_bool(i,j,k) = 1;%�����(i,j)�������ĵ���Ա���j���������ڵ㸲��
                end
            end
        end
    end


    %%�������Ϸֲ�����  �����������Ͽ��Ը��ǵļ��㣬�����ó������жϣ����
    %����һ���ڵ�ʹ���ж������ϰ�����ֹͣ����ɸ���
    for i=1:L/0.1
        for j=1:W/0.1
            for k=1:N
                if Grid_cover_bool(i,j,k) == 1
                    zhangaiwu_flag = get_3D_mangqu(sensor_mat1(:,k),Grid_cen_x_and_y(i,j,:));
                    if zhangaiwu_flag == 0
                        Grid_cover_unit(i,j) = 1;%��ı������ʣ�
                        break;%ֹͣ�ü�����ж�
                    end
                end
            end
        end
    end

    
    
    %���㸲���� �����б����ǵ����� ��Ӧ��������֮��/�����
    sur_area_sum = 0;
    for i=1:L/0.1
        for j=1:W/0.1
            if Grid_cover_unit(i,j) == 1 %�ü��㱻����
                sur_area_sum = sur_area_grid(i,j) + sur_area_sum;
            end
        end
    end


    cover_rate = sur_area_sum/all_sur_area;%������
end