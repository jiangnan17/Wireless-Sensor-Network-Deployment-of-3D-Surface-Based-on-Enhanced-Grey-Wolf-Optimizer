%%��Բ
function draw_MST(x_pos,y_pos,z_pos)
 
    %%�������Ļ���С������
 
    load adjacencyMatrix_dis.mat;
    load adjacencyMatrix.mat;
%     disp('Ȩ��');
%     disp(adjacencyMatrix_dis);
%     disp('�Ƿ���ڱ�');
%     disp(adjacencyMatrix);
%     pause(10);
    [weight_sum, span_tree] = kruskal(adjacencyMatrix, adjacencyMatrix_dis);
    [row,colu] = size(span_tree);%�õ�span_tree�ĺ�������
%     disp('row');
%     disp(row);
%     disp('colu');
%     disp(colu);
%     disp('span_tree');
%     disp(span_tree);
    %ע��plot3��д��
    for i=1:row
        plot3([x_pos(1,span_tree(i,1)),x_pos(1,span_tree(i,2))],[y_pos(1,span_tree(i,1)),y_pos(1,span_tree(i,2))]...
           ,[z_pos(1,span_tree(i,1)),z_pos(1,span_tree(i,2))],'color','b' ,'LineWidth',2);
        hold on;
    end
    disp('��С����������ȨֵΪ');
    disp(weight_sum);

    hold on;
end