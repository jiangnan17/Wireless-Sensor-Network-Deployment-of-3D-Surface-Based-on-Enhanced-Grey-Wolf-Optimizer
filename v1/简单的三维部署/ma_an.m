function y_jian = ma_an(x)

    [row,col] = size(x);%得出行列矩阵的大小  1行两列


    if row > 1
        error('输入的参数错误');
    end
    
    %计算y
    y = zeros(row,col);%分配相应内存
    for i=1:row
        for j=1:col
           y(i,j)  = x(i,j).^2;
        end
    end
    y_jian = y(1,1)  - y(1,2);
end




