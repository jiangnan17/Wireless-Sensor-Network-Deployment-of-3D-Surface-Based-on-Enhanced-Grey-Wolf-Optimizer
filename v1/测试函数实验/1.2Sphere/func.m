%���㺯��ֵ
%Sphere����    ֱ�ӷ��غ�
function y_sum = func(x)
    [row,col] = size(x);
    y = zeros(row,col);%������Ӧ�ڴ�
    for i=1:row
        for j=1:col
           y(i,j)  = (x(i,j))^2;
        end
    end
    y_sum = sum(y);
end


% 