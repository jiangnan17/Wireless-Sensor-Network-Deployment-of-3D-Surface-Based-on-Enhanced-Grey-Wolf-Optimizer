


%%����nΪ2
function Dreama_an_grid(x)
%����Griewank����ͼ��
y = x;
[X,Y] = meshgrid(x,y);
[row,col] = size(X);
Z = zeros(row,col);%Ԥ�����ڴ�
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
%����������
axis([0,10,0,10,-1,1]);%����������С�����ֵ 
set(gca,'xtick',(0:1:10));%����x���경��Ϊ1
set(gca,'ytick',(0:1:10));%����y���경��Ϊ1   ���и����� ����������̫������
set(gca,'ztick',(-1:0.2:1));%����y���경��Ϊ1   ���и����� ����������̫������



