function h = drawSphere(r, centerx, centery, centerz, N)
%ǰ1Ϊ�뾶  2-4 :����  �壺�ܶ�
if nargin == 5% ����������ж�   �����㷨��׳�Ը�ǿ
    [x,y,z] = sphere(N);
else
    [x,y,z] = sphere(50);
end

h = surf(r*x+centerx, r*y+centery, r*z+centerz);
% h.EdgeColor = rand(1,3);
h.EdgeColor = [0,0,1];%��ɫ������
h.FaceColor = h.EdgeColor;


% plot(x,y,'Color',[1 0 0]);�����ɫ
% plot(x,y,'Color',[0 1 0]);������ɫ
% plot(x,y,'Color',[0 0 1]);������ɫ
% plot(x,y,'Color',[0.3 0.8 0.9]);����������ɫ��ɵ�����ɫ
