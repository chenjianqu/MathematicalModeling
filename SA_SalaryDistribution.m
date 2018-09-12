%模拟退火算法
function func12()
clear;
clc;

Money=200000;%总资产为20w
halfM=140000;%前半年工资
MAX_Salary=40000;

a=0.95;%温度T的衰减系数

num=13;%13个工资

E_current=0;%当前解对应的目标函数值
E_best=0;%冷却过程中的找到的最优解

t0=1000;%初始温度
tf=3;%截止温度
t=t0;%当前温度
p=1;

%产生初始解
sol_new=zeros(1,num); 
sol_new(1,1:6)=MAX_Salary*rand(1,6);
%前半年不超过70%
msum=sum(sol_new(1,:));
if msum>halfM
    sol_new(1,1:6)=sol_new(1,1:6).*(halfM/msum);
    msum=sum(sol_new(1,:));
end
%分配后半个月
sol_new(1,7:13)=MAX_Salary*rand(1,7);
hsum=sum(sol_new(1,7:12))+sol_new(1,13)*12;%后半年和年终奖的钱数
%调整和为20w
m=(Money-msum)/hsum;
sol_new(1,7:13)=sol_new(1,7:13).*m;

sol_current=sol_new;%当前解
sol_best=sol_new;%冷却过程中的找到的最优解
E_current=Eval(sol_new);
E_best=E_current;

hh=100;
while hh>0
hh=hh-1;

while t>=tf
    for r=1:500
        %产生随机扰动
        tmp=ceil(rand.*num);%ceil函数朝正无穷方向取整,tmp在1-13范围内
        sol_new(1,tmp)=rand()*MAX_Salary;
        tmp=ceil(rand.*num);%ceil函数朝正无穷方向取整,tmp在1-13范围内
        sol_new(1,tmp)=rand()*MAX_Salary;
        tmp=ceil(rand.*num);%ceil函数朝正无穷方向取整,tmp在1-13范围内
        sol_new(1,tmp)=rand()*MAX_Salary;
        
        %修正数值
        %前半年不超过70%
        msum=sum(sol_new(1,1:6));
        if msum>halfM
            sol_new(1,1:6)=sol_new(1,1:6).*(halfM/msum);
            msum=sum(sol_new(1,:));
        end
        %分配后半个月
        sol_new(1,7:13)=MAX_Salary*rand(1,7);
        hsum=sum(sol_new(1,7:12))+sol_new(1,13)*12;%后半年和年终奖的钱数
        %调整和为20w
        m=(Money-msum)/hsum;
        sol_new(1,7:13)=sol_new(1,7:13).*m;
        
        %计算目标函数
        %计算适应度,即工资发放后投资到年底的总和
        E_new=Eval(sol_new(1,:));
        
        %如果新解的值优于当前解
        if E_new>E_current
            sol_current=sol_new;
            E_current=E_new;
            if E_new>E_best
                %把冷却过程最好的解保存下来
                E_best=E_current;
                sol_best=sol_current;
            end
            
        %新解的值不优于当前解
        else
            if rand<exp(-(E_new-E_current)./t)%有一定的概率接受新解
                E_current=E_new;
                sol_current=sol_new;
            else
                sol_new=sol_current;
            end
        end 
    end
    t=t.*a;
end


end


disp('工资总和：');
sum(sol_new(1,1:12))+sol_new(1,13)*12
disp('最优解为：');
sol_best
disp('最优值');
%E_best
Eval(sol_best)

%计算适应度
function out=Eval(s)
salary_at=zeros(num,1);
ra=0.04;
%计算税后工资
for evi=1:num
    x=s(1,evi);
    if x>38500
        salary_at(1,evi)=x-(45+300+900+6500)-(x-38500)*0.30;
    elseif x>12500
        salary_at(1,evi)=x-(45+300+900)-(x-12500)*0.25;
    elseif x>8000
        salary_at(1,evi)=x-(45+300)-(x-8000)*0.20;
    elseif x>5000
        salary_at(1,evi)=x-45-(x-5000)*0.1;
    elseif x>3500
        salary_at(1,evi)=x-(x-3500)*0.03;
    else
        salary_at(1,evi)=x;
    end
end
%计算到年底的总收入
out=(1+ra*11/12)*0.8*salary_at(1,1)+0.2*salary_at(1,1)...
+(1+ra*10/12)*0.8*salary_at(1,2)+0.2*salary_at(1,2)...
+(1+ra*9/12)*0.8*salary_at(1,3)+0.2*salary_at(1,3)...
+(1+ra*8/12)*0.8*salary_at(1,4)+0.2*salary_at(1,4)...
+(1+ra*7/12)*0.8*salary_at(1,5)+0.2*salary_at(1,5)...
+(1+ra*6/12)*0.8*salary_at(1,6)+0.2*salary_at(1,6)...
+(1+ra*5/12)*0.8*salary_at(1,7)+0.2*salary_at(1,7)...
+(1+ra*4/12)*0.8*salary_at(1,8)+0.2*salary_at(1,8)...
+(1+ra*3/12)*0.8*salary_at(1,9)+0.2*salary_at(1,9)...
+(1+ra*2/12)*0.8*salary_at(1,10)+0.2*salary_at(1,10)...
+(1+ra*1/12)*0.8*salary_at(1,11)+0.2*salary_at(1,11)...
+salary_at(1,12)+salary_at(1,13)*12;

end


end

