%云模型`   \ 
function cloudModel()
clc;
clear;
close all;

%每幅图生成N个云滴
N=1500;
%射击成绩原始数据 数据按列存储,要转置
Y=[9.5 10.3 10.1 8.1
    10.3 9.7 10.4 10.1
    10.6 8.6 9.2 10.0
    10.5 10.4 10.1 10.1
    10.9 9.8 10.0 10.1
    10.6 9.8 9.7 10.0
    10.4 10.5 10.6 10.3
    10.1 10.2 10.8 8.4
    9.3 10.2 9.6 10.0
    10.5 10.0 10.7 9.9]';

%遍历所有的行(size(Y,1)得到行数)
for i=1:size(Y,1)
    subplot(size(Y,1)/2,2,i);
    [x,y,Ex,En,He]=cloud_transform(Y(i,:),N);
    plot(x,y,'r.');
    xlabel('射击成绩分布/环');
    ylabel('确定度');
    title(strcat('第',num2str(i),'人射击云模型还原图谱'));
    axis([8,12,0,1]);%控制坐标轴的范围
end
    
    function [x,y,Ex,En,He]=cloud_transform(y_spor,n)
       %Ex是云模型的数字特征,是原始数据的期望;
       %En也是云模型的数字特征,表示熵;(不确定程度,由离群程度和模糊程度共同共同决定)
       %He同样是云模型的数字特征,表示超熵.(度量熵的不确定程度,即熵的熵)
       %x表示云滴,y表示隶属度,度量倾向的稳定程度;(x,y)是论域U的一个云滴,
       
       %正向云发生器,用来生成云滴(如下):
       %En'是以En为期望,He为方差的正太随机数
       %x是以Ex为期望,En'为方差的正太随机数
       %隶属度y的计算方法:y=exp(-(x-Ex)^2/(2*E'^2))
       
       %逆向云发生器,用来计算云滴的数据特征,如下(无需确定度信息的逆向发生器):
       %Ex=样本均值;
       %En=sqrt(pi/2)*mean(abs(x-Ex))
       %He=sqrt(var(x)-En^2) 其中var是计算方差 
       
       
       Ex=mean(y_spor);%求期望,
       En=mean(abs(y_spor-Ex)).*sqrt(pi./2);%求熵
       He=sqrt(var(y_spor)-En.^2);%求超熵
       for q=1:n
           Enn=rand(1).*He+En;
           x(q)=randn(1).*Enn+Ex;
           y(q)=exp(-(x(q)-Ex).^2./(2.*Enn.^2));
       end
       x;
       y;
    end
end