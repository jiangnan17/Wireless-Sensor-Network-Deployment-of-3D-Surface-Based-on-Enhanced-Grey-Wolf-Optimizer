%%����nΪ2
function DrawSphere()
%����Griewank����ͼ��
x = (-100:1:100);
y = x;
[X,Y] = meshgrid(x,y);
[row,col] = size(X);
Z = zeros(row,col);%Ԥ�����ڴ�
for lo=1:col
    for h=1:row
        Z(h,lo) = sphere([X(h,lo),Y(h,lo)]);
    end
end
% surf(X,Y,Z);
surfc(X,Y,Z,'LineStyle','none');%��������Ч�����ÿ�
shading interp;