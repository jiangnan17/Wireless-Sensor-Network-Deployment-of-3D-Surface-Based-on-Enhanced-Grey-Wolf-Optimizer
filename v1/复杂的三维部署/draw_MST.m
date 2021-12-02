%%画圆
function draw_MST(x_pos,y_pos,z_pos)
 
    %%进行最后的画最小生成树
 
    load adjacencyMatrix_dis.mat;
    load adjacencyMatrix.mat;
%     disp('权重');
%     disp(adjacencyMatrix_dis);
%     disp('是否存在边');
%     disp(adjacencyMatrix);
%     pause(10);
    [weight_sum, span_tree] = kruskal(adjacencyMatrix, adjacencyMatrix_dis);
    [row,colu] = size(span_tree);%得到span_tree的横纵坐标
%     disp('row');
%     disp(row);
%     disp('colu');
%     disp(colu);
%     disp('span_tree');
%     disp(span_tree);
    %注意plot3的写法
    for i=1:row
        plot3([x_pos(1,span_tree(i,1)),x_pos(1,span_tree(i,2))],[y_pos(1,span_tree(i,1)),y_pos(1,span_tree(i,2))]...
           ,[z_pos(1,span_tree(i,1)),z_pos(1,span_tree(i,2))],'color','b' ,'LineWidth',2);
        hold on;
    end
    disp('最小生成树的总权值为');
    disp(weight_sum);

    hold on;
end