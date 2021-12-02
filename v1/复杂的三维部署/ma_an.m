function y_jian = ma_an(x)

    [row,col] = size(x);%得出行列矩阵的大小  1行两列


    if row > 1
        error('输入的参数错误');
    end
    
    y_jian = sin(x(1,2))*cos(x(1,1)); 
end




