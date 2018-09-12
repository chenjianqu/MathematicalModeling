%模拟退火算法

%0-1背包问题:有12件物品，包的最大允许重量为46磅，求带走的东西最值钱
clear;
clc;
a=0.95;%温度T的衰减系数
k=[5;10;13;4;3;11;13;10;8;16;7;4];%各个物品的价值
k=-k;%模拟退火算法求得是最小值，我们要求最大值，故取负数
d=[2;5;18;3;2;5;10;4;11;7;14;6];%各物品的重量
restriction=46;%最大值
num=12;%12个物品
sol_new=ones(1,num);%产生初始解
E_current=inf;%当前解对应的目标函数值
E_best=inf;%冷却过程中的找到的最优解
sol_current=sol_new;%当前解
sol_best=sol_new;%冷却过程中的找到的最优解
t0=97;
tf=3;
t=t0;
p=1;

while t>=tf
    for r=1:100
        %产生随机扰动
        tmp=ceil(rand.*num);%ceil函数朝正无穷方向取整,tmp在1-12范围内
        sol_new(1,tmp)=~sol_new(1,tmp);%将某个物品丢弃
        
        %检查是否满足约束
        while 1
            q=(sol_new*d<=restriction);%新产生选择是否在46磅范围内
            if ~q%如果不在
                p=~p;
                tmp=find(sol_new==1);%返回sol_new中元素等于1的位置
                if p
                    sol_new(1,tmp)=1;
                else
                    sol_new(1,tmp(end))=0;%tmp(end)表示tmp中最后一个元素的值
                end
            else%若满足条件则跳出循环
                break;
            end
        end
        
        %计算背包中的物品价值
        E_new=sol_new*k;
        %如果新解的值优于当前解
        if E_new<E_current
            E_current=E_new;
            sol_current=sol_new;
            if E_new<E_best
                %把冷却过程最好的解保存下来
                E_best=E_new;
                sol_best=sol_new;
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

disp('最优解为：');
sol_best
disp('物品总价值为：');
-E_best
disp('背包中物品的重量为：');
sol_best*d

