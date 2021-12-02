function is_connec = get_3D_connection(sensor_mat)
    global N;
	%ɾ���ϴε��ڽӾ����ļ�
	delete('adjacencyMatrix_dis.mat');
	delete('adjacencyMatrix.mat');

	%%������ͨ��
	adjacencyMatrix = zeros(N,N);%���崫���������ڽӾ���
	adjacencyMatrix_dis = zeros(N,N);%���崫���������ڽӾ���
	for i=1:1:N
        for j=(i+1):1:N   %��Ϊ�ж��ְ뾶  ��ͨ�ý��д���
            [connection_flag,dis] = is_connection(sensor_mat(:,i),sensor_mat(:,j));
            adjacencyMatrix(i,j) = connection_flag;
			adjacencyMatrix(j,i) = connection_flag;
            
            %�ٿ��������֪�������  ���������
            if connection_flag == 1
                adjacencyMatrix_dis(i,j) = dis;%����ͼ
                adjacencyMatrix_dis(j,i) = dis;
            end
        end
	end 

	%�������һ�ε�����ͼ�ڽӾ���
	save adjacencyMatrix_dis.mat adjacencyMatrix_dis;
	save adjacencyMatrix.mat adjacencyMatrix;
	S=zeros(N,N);
	for m=1:1:N-1
		S=S+adjacencyMatrix^m;  %ȫ���ӵ�S
	end;

	%S=M+M^2+M^3+...+M^(N-1)��
	%����N��M������������
	%��S����Ԫ��Ϊ�㣬����ͨ��
	%S�����㣬����ͨ��
	%�������ڽӾ���ͼ����ͨ���ж�׼�򡷲鵽��
	is_connec = 0;%��ʼ��Ϊ����ͨ
    if all(all(S))==1 %�ж�S�����ǲ���ȫΪ����Ԫ��
        is_connec = 1;%ȫΪ��0  ����ͨ
    end
    
%     disp(adjacencyMatrix);
end