%�ж������ڵ��Ƿ���ͨ ������ͨ���  ��  ���� ��Ϊ������С������)
function [connection_flag,dis] = is_connection(serson_firtst,serson_second)

    global r;%��֪�뾶  ͨ�Ű뾶Ϊ��֪�뾶������
    connection_flag = 0;  % Ĭ�����ϰ������ͨ
    
    
    %���ȵ�����ŷʽ���룬���򳹵ײ���ͨ
    dis = ((serson_firtst(1,1) - serson_second(1,1))^2 + (serson_firtst(2,1) - serson_second(2,1))^2 +...
            (serson_firtst(3,1) - serson_second(3,1))^2)^0.5;
    if dis > 2*r
        connection_flag = 0;%����ͨ
        return ;
    end
    
    
    %���¿�ʼ
    
    x1 = serson_firtst(1,1);
    y1 = serson_firtst(2,1);
    z1 = serson_firtst(3,1);
    
    x2 = serson_second(1,1);
    y2 = serson_second(2,1);
    z2 = serson_second(3,1);
    
    
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
    
    
    

    
    %����  �����С����
    [x_lower_upper] = sort([x1,x2]);
    %�������   �ڸ÷�Χ�����
    x_lower = x_lower_upper(1,1);
    x_upper = x_lower_upper(1,2);
    
  
    %�Խ���ж�   �޽�
    if deta < 0
        connection_flag = 1;%���ϰ���  ��ͨ
        return ;
    end
    
    %������
    solu_1 = (-B + deta^0.5) / (2*A);
    solu_2 = (-B - deta^0.5) / (2*A);
    
    
    %  ��������������������
    if (solu_1 <= x_lower  || solu_1 >= x_upper) && (solu_2 <= x_lower  || solu_2 >= x_upper)
        connection_flag = 1;
    end
   
   %����Ŀǰ�ж������ϰ����  ���ý���һ���ռ��ж�
    mid_point = (serson_firtst + serson_second)/2;
    if ma_an([mid_point(1,1),mid_point(2,1)]) > mid_point(3,1)
        connection_flag = 0;
    end
end
