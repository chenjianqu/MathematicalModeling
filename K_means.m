%K-means�㷨,�����ݽ��з���
clc;
clear;
%��20��������ÿ��������������
x=[0 0;1 0;0 1;1 1;2 1;1 2;2 2;3 2;6 6;7 6;8 6;6 7;7 7;8 7;9 7;7 8;8 8;9 8;8 9;9 9];
z=zeros(2,2);
z1=zeros(2,2);%�������������
z=x(1:2,1:2);

%Ѱ�Ҿ�������
while 1
    count=zeros(2,1);%ÿ���صĸ���
    allsum=zeros(2,2);%����������Ԫ�صĺ�
    for i=1:20
        %��ÿ������i�����㵽�����������ĵľ���
        temp1=sqrt((z(1,1)-x(i,1)).^2+(z(1,2)-x(i,2)).^2);
        temp2=sqrt((z(2,1)-x(i,1)).^2+(z(2,2)-x(i,2)).^2);
        %���ݸõ���������ĵ�Զ������
        if(temp1<temp2)
            count(1)=count(1)+1;
            allsum(1,1)=allsum(1,1)+x(i,1);
            allsum(1,2)=allsum(1,2)+x(i,2);
        else
            count(2)=count(2)+1;
            allsum(2,1)=allsum(2,1)+x(i,1);
            allsum(2,2)=allsum(2,2)+x(i,2);
        end
    end
    %����ȥ�����ص�ƽ��ֵ��Ϊ�ص�����
    z1(1,1)=allsum(1,1)/count(1);
    z1(1,2)=allsum(1,2)/count(1);
    z1(2,1)=allsum(2,1)/count(2);
    z1(2,2)=allsum(2,2)/count(2);
    %ֱ�������������Ĳ��ٱ仯ʱ����ѭ��
    if(z==z1)
        break;
    else
        z=z1;
    end
end

%%
%�����ʾ
disp(z1);%�����������
plot(x(:,1),x(:,2),'b*');
hold on
plot(z1(:,1),z1(:,2),'ro');
title('K��ֵ������ͼ');
xlabel('����x1');
ylabel('����x2');