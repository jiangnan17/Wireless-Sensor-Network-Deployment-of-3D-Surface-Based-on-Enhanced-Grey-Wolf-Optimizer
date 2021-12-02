%判断两个节点是否连通 返回连通标记  和  距离 （为产生最小生成树)
function [connection_flag,dis] = is_connection(serson_firtst,serson_second)

    global r;%感知半径  通信半径为感知半径的两倍
    connection_flag = 0;  % 默认有障碍物，不连通
    
    
    %首先得满足欧式距离，否则彻底不连通
    dis = ((serson_firtst(1,1) - serson_second(1,1))^2 + (serson_firtst(2,1) - serson_second(2,1))^2 +...
            (serson_firtst(3,1) - serson_second(3,1))^2)^0.5;
    if dis > 2*r
        connection_flag = 0;%不连通
        return ;
    end
    
    
    %重新开始
    
    x1 = serson_firtst(1,1);
    y1 = serson_firtst(2,1);
    z1 = serson_firtst(3,1);
    
    x2 = serson_second(1,1);
    y2 = serson_second(2,1);
    z2 = serson_second(3,1);
    
    
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
    
    
    

    
    %排序  区间从小到大
    [x_lower_upper] = sort([x1,x2]);
    %求得区间   在该范围内求解
    x_lower = x_lower_upper(1,1);
    x_upper = x_lower_upper(1,2);
    
  
    %对解的判断   无解
    if deta < 0
        connection_flag = 1;%无障碍物  连通
        return ;
    end
    
    %两个解
    solu_1 = (-B + deta^0.5) / (2*A);
    solu_2 = (-B - deta^0.5) / (2*A);
    
    
    %  或者两个解在区间外面
    if (solu_1 <= x_lower  || solu_1 >= x_upper) && (solu_2 <= x_lower  || solu_2 >= x_upper)
        connection_flag = 1;
    end
   
   %对于目前判断是无障碍物的  还得进行一个终极判断
    mid_point = (serson_firtst + serson_second)/2;
    if ma_an([mid_point(1,1),mid_point(2,1)]) > mid_point(3,1)
        connection_flag = 0;
    end
end
