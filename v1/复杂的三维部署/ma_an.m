function y_jian = ma_an(x)

    [row,col] = size(x);%�ó����о���Ĵ�С  1������


    if row > 1
        error('����Ĳ�������');
    end
    
    y_jian = sin(x(1,2))*cos(x(1,1)); 
end




