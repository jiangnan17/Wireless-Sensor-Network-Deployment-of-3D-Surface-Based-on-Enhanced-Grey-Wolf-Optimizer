function  zhangaiwu_flag = get_3D_mangqu(serson_x_y_z,moni_x_y_z)

%     warning off;
    zhangaiwu_flag = 0;  % Ĭ�����ϰ������ֻ��Ҫ�ж����ϰ�������
    %���¿�ʼ
    x1 = serson_x_y_z(1,1);
    y1 = serson_x_y_z(2,1);
    z1 = serson_x_y_z(3,1);
    
    x2 = moni_x_y_z(1,1,1);
    y2 = moni_x_y_z(1,1,2);
    z2 = moni_x_y_z(1,1,3);
    
    
    %��������  ��ɷ��Ż�
    a = z2 - z1;
    b = x2 - x1;
    c = x1;
    d = z1;
    f = y2 - y1;
    g = y1;
    
  
   
%     answer = fsolve(@(y)(y-g).*a./f+d - sin(y).*cos((y-g).*b./f+c),[y1,(y1+y2)/2,y2],optimset('Display','off'));
%     sort_y = sort([y1,y2]);%����
%     answer_sort = sort(answer);
%     sort_y_1 = sort_y(1,1);
%     sort_y_2 = sort_y(1,2);
%     
%     anser_1 = answer_sort(1,1);%��һ����
%     anser_2 = answer_sort(1,2);%��һ����
%     anser_3 = answer_sort(1,3);%��һ����
%     if (anser_2>sort_y_1 && anser_2<sort_y_2) && ((abs(anser_2-sort_y_1))>0.05 || (abs(anser_2-sort_y_2))>0.05)
%         zhangaiwu_flag = 1;
%     end
%     disp(sort_y_1);
%     disp(sort_y_2);
%     disp('laal');
% 
%     disp(answer_sort);
%     disp('hahah');
%     pause(1);
    
   
%     if zhangaiwu_flag == 1
%         disp('���ϰ���');
%     else
%         disp('���ϰ���');
%     end

%�ж��Ƿ��ڰ�͹������
      if ma_an([(x1+x2)/2 (y1+y2)/2]) > (z1+z2)/2
          zhangaiwu_flag = 1;
      end
end
