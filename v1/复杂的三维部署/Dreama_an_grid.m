


%%构造n为2
function Dreama_an_grid(x)
%绘制Griewank函数图形
y = x;
[X,Y] = meshgrid(x,y);
[row,col] = size(X);
Z = zeros(row,col);%预分配内存
for lo=1:col
    for h=1:row
        Z(h,lo) = ma_an([X(h,lo),Y(h,lo)]);
    end
end
C = gradient(Z);

% mesh(X,Y,Z,C);
% colormap(cool);
surf(X,Y,Z);
shading faceted;
%建立的曲面
axis([0,10,0,10,-1,1]);%横纵坐标最小和最大值 
set(gca,'xtick',(0:1:10));%设置x坐标步长为1
set(gca,'ytick',(0:1:10));%设置y坐标步长为1   还有个问题 横坐标数字太紧凑了
set(gca,'ztick',(-1:0.2:1));%设置y坐标步长为1   还有个问题 横坐标数字太紧凑了



