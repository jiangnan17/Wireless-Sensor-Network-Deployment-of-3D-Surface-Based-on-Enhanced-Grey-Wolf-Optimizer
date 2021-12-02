%计算函数值
%Sphere函数    直接返回和
function y_sum = func(x)
    [row,col] = size(x);
    y = zeros(row,col);%分配相应内存
    for i=1:row
        for j=1:col
           y(i,j)  = (x(i,j))^2;
        end
    end
    y_sum = sum(y);
end


% 