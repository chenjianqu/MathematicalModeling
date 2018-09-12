%ģ���˻��㷨
function func12()
clear;
clc;

Money=200000;%���ʲ�Ϊ20w
halfM=140000;%ǰ���깤��
MAX_Salary=40000;

a=0.95;%�¶�T��˥��ϵ��

num=13;%13������

E_current=0;%��ǰ���Ӧ��Ŀ�꺯��ֵ
E_best=0;%��ȴ�����е��ҵ������Ž�

t0=1000;%��ʼ�¶�
tf=3;%��ֹ�¶�
t=t0;%��ǰ�¶�
p=1;

%������ʼ��
sol_new=zeros(1,num); 
sol_new(1,1:6)=MAX_Salary*rand(1,6);
%ǰ���겻����70%
msum=sum(sol_new(1,:));
if msum>halfM
    sol_new(1,1:6)=sol_new(1,1:6).*(halfM/msum);
    msum=sum(sol_new(1,:));
end
%���������
sol_new(1,7:13)=MAX_Salary*rand(1,7);
hsum=sum(sol_new(1,7:12))+sol_new(1,13)*12;%���������ս���Ǯ��
%������Ϊ20w
m=(Money-msum)/hsum;
sol_new(1,7:13)=sol_new(1,7:13).*m;

sol_current=sol_new;%��ǰ��
sol_best=sol_new;%��ȴ�����е��ҵ������Ž�
E_current=Eval(sol_new);
E_best=E_current;

hh=100;
while hh>0
hh=hh-1;

while t>=tf
    for r=1:500
        %��������Ŷ�
        tmp=ceil(rand.*num);%ceil�������������ȡ��,tmp��1-13��Χ��
        sol_new(1,tmp)=rand()*MAX_Salary;
        tmp=ceil(rand.*num);%ceil�������������ȡ��,tmp��1-13��Χ��
        sol_new(1,tmp)=rand()*MAX_Salary;
        tmp=ceil(rand.*num);%ceil�������������ȡ��,tmp��1-13��Χ��
        sol_new(1,tmp)=rand()*MAX_Salary;
        
        %������ֵ
        %ǰ���겻����70%
        msum=sum(sol_new(1,1:6));
        if msum>halfM
            sol_new(1,1:6)=sol_new(1,1:6).*(halfM/msum);
            msum=sum(sol_new(1,:));
        end
        %���������
        sol_new(1,7:13)=MAX_Salary*rand(1,7);
        hsum=sum(sol_new(1,7:12))+sol_new(1,13)*12;%���������ս���Ǯ��
        %������Ϊ20w
        m=(Money-msum)/hsum;
        sol_new(1,7:13)=sol_new(1,7:13).*m;
        
        %����Ŀ�꺯��
        %������Ӧ��,�����ʷ��ź�Ͷ�ʵ���׵��ܺ�
        E_new=Eval(sol_new(1,:));
        
        %����½��ֵ���ڵ�ǰ��
        if E_new>E_current
            sol_current=sol_new;
            E_current=E_new;
            if E_new>E_best
                %����ȴ������õĽⱣ������
                E_best=E_current;
                sol_best=sol_current;
            end
            
        %�½��ֵ�����ڵ�ǰ��
        else
            if rand<exp(-(E_new-E_current)./t)%��һ���ĸ��ʽ����½�
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


disp('�����ܺͣ�');
sum(sol_new(1,1:12))+sol_new(1,13)*12
disp('���Ž�Ϊ��');
sol_best
disp('����ֵ');
%E_best
Eval(sol_best)

%������Ӧ��
function out=Eval(s)
salary_at=zeros(num,1);
ra=0.04;
%����˰����
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
%���㵽��׵�������
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

