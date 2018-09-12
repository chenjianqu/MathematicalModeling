%K-means算法,对数据进行分类
clc;
clear;
%有20个样本，每个样本两个特征
x=[0 0;1 0;0 1;1 1;2 1;1 2;2 2;3 2;6 6;7 6;8 6;6 7;7 7;8 7;9 7;7 8;8 8;9 8;8 9;9 9];
z=zeros(2,2);
z1=zeros(2,2);%两个聚类的中心
z=x(1:2,1:2);

%寻找聚类中心
while 1
    count=zeros(2,1);%每个簇的个数
    allsum=zeros(2,2);%两个聚类中元素的和
    for i=1:20
        %对每个样本i，计算到两个聚类中心的距离
        temp1=sqrt((z(1,1)-x(i,1)).^2+(z(1,2)-x(i,2)).^2);
        temp2=sqrt((z(2,1)-x(i,1)).^2+(z(2,2)-x(i,2)).^2);
        %根据该点离聚类中心的远近分类
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
    %根据去各个簇的平均值作为簇的中心
    z1(1,1)=allsum(1,1)/count(1);
    z1(1,2)=allsum(1,2)/count(1);
    z1(2,1)=allsum(2,1)/count(2);
    z1(2,2)=allsum(2,2)/count(2);
    %直到各个聚类中心不再变化时跳出循环
    if(z==z1)
        break;
    else
        z=z1;
    end
end

%%
%结果显示
disp(z1);%输出聚类中心
plot(x(:,1),x(:,2),'b*');
hold on
plot(z1(:,1),z1(:,2),'ro');
title('K均值法分类图');
xlabel('特征x1');
ylabel('特征x2');