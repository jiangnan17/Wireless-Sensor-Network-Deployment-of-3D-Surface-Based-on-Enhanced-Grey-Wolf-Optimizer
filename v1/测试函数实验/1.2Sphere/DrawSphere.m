%%构造n为2
function DrawSphere()
%绘制Griewank函数图形
x = (-100:1:100);
y = x;
[X,Y] = meshgrid(x,y);
[row,col] = size(X);
Z = zeros(row,col);%预分配内存
for lo=1:col
    for h=1:row
        Z(h,lo) = sphere([X(h,lo),Y(h,lo)]);
    end
end
% surf(X,Y,Z);
surfc(X,Y,Z,'LineStyle','none');%增加这句更效果更好看
shading interp;