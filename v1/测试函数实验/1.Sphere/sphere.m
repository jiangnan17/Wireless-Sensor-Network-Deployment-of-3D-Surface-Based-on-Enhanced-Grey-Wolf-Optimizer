function y_sum = sphere(x)
    %sphere ���� 
    %����x��������Ӧ��yֵ����x=(0,0,0...0)ȡ��ȫ����Сֵ0
    [row,col] = size(x);%�ó����о���Ĵ�С  1������


    if row > 1
        error('����Ĳ�������');
    end
    
    %����y
    y = zeros(row,col);%������Ӧ�ڴ�
    for i=1:row
        for j=1:col
           y(i,j)  = x(i,j)^2;
        end
    end
    y_sum = sum(y);
end




