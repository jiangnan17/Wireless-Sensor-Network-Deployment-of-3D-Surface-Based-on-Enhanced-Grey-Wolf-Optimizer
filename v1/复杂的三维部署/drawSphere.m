function h = drawSphere(r, centerx, centery, centerz, N)
%前1为半径  2-4 :坐标  五：密度
if nargin == 5% 输入参数的判断   这样算法健壮性更强
    [x,y,z] = sphere(N);
else
    [x,y,z] = sphere(50);
end

h = surf(r*x+centerx, r*y+centery, r*z+centerz);
% h.EdgeColor = rand(1,3);
h.EdgeColor = [0,0,1];%蓝色的球体
h.FaceColor = h.EdgeColor;


% plot(x,y,'Color',[1 0 0]);代表红色
% plot(x,y,'Color',[0 1 0]);代表绿色
% plot(x,y,'Color',[0 0 1]);代表蓝色
% plot(x,y,'Color',[0.3 0.8 0.9]);则是三种颜色组成的新颜色
