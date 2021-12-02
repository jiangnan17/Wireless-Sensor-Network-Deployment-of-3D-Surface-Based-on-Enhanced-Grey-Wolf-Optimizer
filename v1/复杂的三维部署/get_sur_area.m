function sur_area = test_x(x1,x2,y1,y2)    
    f = @(x,y)(1+sin(x).^2.*sin(y).^2+cos(x).^2.*cos(y).^2).^0.5;%й╫вс
    sur_area = integral2(f,x1,x2,y1,y2);%[x1,x2],[y1,y2]
end
    