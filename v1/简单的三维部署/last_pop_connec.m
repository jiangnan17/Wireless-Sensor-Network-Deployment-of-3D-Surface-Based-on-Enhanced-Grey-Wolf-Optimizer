function  last_pop_connec(wolf_pop,sizepop,all_sur_area)
    cout_nec = 0;
    matrix_flag = zeros(1,sizepop);%���ڱ���Ƿ�Ϊ��ͨ
    for zz =1:sizepop  

        best_indivi = wolf_pop(:,:,zz);
    %     disp('������ͨ�Ե��ж�...');
    %     pause(1);
        %��ͨ�Ե��ж�
        is_connec = get_3D_connection(best_indivi);
        if is_connec == 1
            matrix_flag(1,zz) = 1;%���Ϊ1
            cout_nec = cout_nec + 1;
    %         disp('������������ͨ��');
        else
    %         disp('�������粻����ͨ��');
        end





        %��С�������Ĳ���
    %     figure(10);
    %     x_range_point = (-1:0.1:1);%��ϻ�����
    %     Dreama_an_grid(x_range_point);
    %     hold on;
    %     axis([-1,1,-1,1,-1,1]);%����������С�����ֵ 
    %     hold on;
    %     for i=1:N
    %         plot3(best_indivi(1,i),best_indivi(2,i),best_indivi(3,i),'.','MarkerSize',20,'color','r');%������ 
    %         hold on;
    %     end
    %     grid on
    %     draw_MST(best_indivi(1,:),best_indivi(2,:),best_indivi(3,:));
    %     hold on;
    % 
    %     disp('������');
    %     disp(get_Grid_cover_unit_and_rate(best_indivi,all_sur_area));
    end
    disp('��ͨ��');
    disp(cout_nec/sizepop);

    %����ͨ��ƽ���ĸ�����
    cout_coverage = 0;
    for k=1:sizepop
        if matrix_flag(1,k) == 1
            cout_coverage = cout_coverage + get_Grid_cover_unit_and_rate(wolf_pop(:,:,k),all_sur_area);
        end
    end

    disp('��ͨ����µ�ƽ��������');
    disp(cout_coverage/cout_nec);
end
