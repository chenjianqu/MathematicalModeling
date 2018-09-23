
%����ʽ���
clc,clear;
x=1:0.1:(10-0.1);
y=x.^2-x+4;
y=y+2.*randn(1,length(x));

p=polyfit(x,y,3)
y_1=polyval(p,x);

figure(1);
plot(x,y,'r.',x,y_1);


%�Զ��庯�����
f=fittype('a*2.71^(k*x)','independent','x','coefficients',{'a','k'});
opt=fitoptions(f);
opt.StartPoint=[1,2];%�趨��ϵĳ�ֵa=1 k=2
c=fit(x',y',f,opt)
y_2=c(x);
figure(2);
plot(x,y,'r.',x,y_2);

