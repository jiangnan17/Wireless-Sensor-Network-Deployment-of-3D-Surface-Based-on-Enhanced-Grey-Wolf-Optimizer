function sur_area = test_x(x1,x2,y1,y2)    
    f = @(x,y)(1+4*x.^4 + 4*y.^4).^0.5;%й╫вс
    sur_area = integral2(f,x1,x2,y1,y2);%[x1,x2],[y1,y2]
end