function draw_ball(r, centerx, centery, centerz)
    h1 = drawSphere(r, centerx, centery, centerz);%前三位坐标  后为半径
%     axis equal;
end

% [x,y,z]  = ellipsoid(8,9,10,2,2,2);
% surf(x,y,z) %画出来球
% axis equal %保证各个维度的长短一致
% axis([1 50 1 50 1 0]);



% theta=0:pi/12:2*pi;
% phy=0:pi/24:pi;
% [theta,phy]=meshgrid(theta,phy);
% r=2;
% x=r.*sin(phy).*cos(theta);
% y=r.*sin(phy).*sin(theta);
% z=r.*cos(phy);
% surf(x,y)


% [x,y,z]=ellipsoid(0,0,0,2,2,2) ;%  (0,0,0) 半径为2
% surf(x,y,z) ;
% axis equal;

% figure
% daspect([1 1 1])
% light
% [x,y,z] = sphere;
% c=ones(size(x));
% hold on
% 
% surf(x,y,z,'facecolor',[0.4 0.6 0.8],'EdgeColor','none');
% surf(x+3,y,z,'facecolor',[0.8 0.8 0.4],'EdgeColor','none');
% surf(x+6,y,z,'facecolor',[0.8 0.4 0.6],'EdgeColor','none');




