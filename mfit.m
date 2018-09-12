clc;clear;
x=1:40000;
size(x)
y=zeros(1,40000);

for i=1:40000
    if x(1,i)<5000
        y(1,i)=(x(1,i)-3500)*0.03;
    elseif x(1,i)<8000
        y(1,i)=(x(1,i)-5000)*0.1+45;
    elseif x(1,i)<12500
        y(1,i)=(x(1,i)-8000)*0.2+45+300;
    elseif x(1,i)<38500
        y(1,i)=(x(1,i)-12500)*0.25+45+300+900;
    else
        y(1,i)=(x(1,i)-38500)*0.3+45+300+900+6500;
    end
end

y1=polyfit(x,y,4)

vpa(y1(1,1))
vpa(y1(1,2))
vpa(y1(1,3))
vpa(y1(1,4))
vpa(y1(1,5))

y2=polyval(y1,x);
figure();
plot(x,y2,x,y);
legend('拟合的曲线','工资与税收曲线');

var(y2-y)
