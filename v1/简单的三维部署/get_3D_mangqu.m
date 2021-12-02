function  zhangaiwu_flag = get_3D_mangqu(serson_x_y_z,moni_x_y_z)

    

    
    %重新开始
    x1 = serson_x_y_z(1,1);
    y1 = serson_x_y_z(2,1);
    z1 = serson_x_y_z(3,1);
    
    x2 = moni_x_y_z(1,1,1);
    y2 = moni_x_y_z(1,1,2);
    z2 = moni_x_y_z(1,1,3);
    
    
    %进行整理  变成符号化
    a = z2 - z1;
    b = x2 - x1;
    c = x1;
    d = z1;
    f = y2 - y1;
    g = y1;
    
    
    %一元二次方程求解
    A = (f^2 / b^2) - 1;
    B = a/b + (-2*c*f^2 + 2*f*b*g) / b^2;
    C = -(a*c/b) + d + (c^2*f^2 - 2*c*f*b*g + b^2*g^2) / b^2;
    deta = B^2 - 4*A*C;
    
    
    

    zhangaiwu_flag = 1;  % 默认有障碍物，所以只需要判断无障碍物的情况
    %排序  区间从小到大
    [x_lower_upper] = sort([x1,x2]);
    %求得区间   在该范围内求解
    x_lower = x_lower_upper(1,1);
    x_upper = x_lower_upper(1,2);
    
  
    %对解的判断   无解
    if deta < 0
        zhangaiwu_flag = 0;%无障碍物标志
        return ;
    end
    
    %两个解
    solu_1 = (-B + deta^0.5) / (2*A);
    solu_2 = (-B - deta^0.5) / (2*A);
    

    

    %  或者两个解在区间外面
    if (solu_1 <= x_lower  || solu_1 >= x_upper) && (solu_2 <= x_lower  || solu_2 >= x_upper)
        zhangaiwu_flag = 0;
    end
    

    %再进行一个判断
    
    %对于目前判断是无障碍物的  还得进行一个终极判断
    mid_point = [(serson_x_y_z(1,1) + moni_x_y_z(1,1,1))/2,(serson_x_y_z(2,1) + moni_x_y_z(1,1,2))/2,(serson_x_y_z(3,1) + moni_x_y_z(1,1,3))/2];
    if ma_an([mid_point(1,1),mid_point(1,2)]) > mid_point(1,3)
        zhangaiwu_flag = 1;
    end
    
end
