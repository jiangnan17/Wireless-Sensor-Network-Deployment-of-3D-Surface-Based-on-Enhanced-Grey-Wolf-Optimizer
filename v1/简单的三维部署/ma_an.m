function y_jian = ma_an(x)

    [row,col] = size(x);%�ó����о���Ĵ�С  1������


    if row > 1
        error('����Ĳ�������');
    end
    
    %����y
    y = zeros(row,col);%������Ӧ�ڴ�
    for i=1:row
        for j=1:col
           y(i,j)  = x(i,j).^2;
        end
    end
    y_jian = y(1,1)  - y(1,2);
end




