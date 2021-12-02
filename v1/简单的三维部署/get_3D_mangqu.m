function  zhangaiwu_flag = get_3D_mangqu(serson_x_y_z,moni_x_y_z)

    

    
    %���¿�ʼ
    x1 = serson_x_y_z(1,1);
    y1 = serson_x_y_z(2,1);
    z1 = serson_x_y_z(3,1);
    
    x2 = moni_x_y_z(1,1,1);
    y2 = moni_x_y_z(1,1,2);
    z2 = moni_x_y_z(1,1,3);
    
    
    %��������  ��ɷ��Ż�
    a = z2 - z1;
    b = x2 - x1;
    c = x1;
    d = z1;
    f = y2 - y1;
    g = y1;
    
    
    %һԪ���η������
    A = (f^2 / b^2) - 1;
    B = a/b + (-2*c*f^2 + 2*f*b*g) / b^2;
    C = -(a*c/b) + d + (c^2*f^2 - 2*c*f*b*g + b^2*g^2) / b^2;
    deta = B^2 - 4*A*C;
    
    
    

    zhangaiwu_flag = 1;  % Ĭ�����ϰ������ֻ��Ҫ�ж����ϰ�������
    %����  �����С����
    [x_lower_upper] = sort([x1,x2]);
    %�������   �ڸ÷�Χ�����
    x_lower = x_lower_upper(1,1);
    x_upper = x_lower_upper(1,2);
    
  
    %�Խ���ж�   �޽�
    if deta < 0
        zhangaiwu_flag = 0;%���ϰ����־
        return ;
    end
    
    %������
    solu_1 = (-B + deta^0.5) / (2*A);
    solu_2 = (-B - deta^0.5) / (2*A);
    

    

    %  ��������������������
    if (solu_1 <= x_lower  || solu_1 >= x_upper) && (solu_2 <= x_lower  || solu_2 >= x_upper)
        zhangaiwu_flag = 0;
    end
    

    %�ٽ���һ���ж�
    
    %����Ŀǰ�ж������ϰ����  ���ý���һ���ռ��ж�
    mid_point = [(serson_x_y_z(1,1) + moni_x_y_z(1,1,1))/2,(serson_x_y_z(2,1) + moni_x_y_z(1,1,2))/2,(serson_x_y_z(3,1) + moni_x_y_z(1,1,3))/2];
    if ma_an([mid_point(1,1),mid_point(1,2)]) > mid_point(1,3)
        zhangaiwu_flag = 1;
    end
    
end
