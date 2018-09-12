function GA_GeneticAlgorithm()

%遗传算法

%编码
clc;
clear;
tic;

Money=200000;%总资产为20w
halfM=140000;%前半年工资
NUM=100;%种群规模
MAX_GEN=2000;%最大遗传代数
NVAR=13;%染色体数目
CrossvoerFraction=0.2;%交叉概率
MigrationFraction=0.2;%变异概率
MAX_Salary=40000;%基因的最大值
Array=zeros(1,MAX_GEN);%各代的平均目标值
Array1=zeros(1,MAX_GEN);%各代的最优目标值

%产生初始种群,每个个体有13个基因
population=zeros(NUM,NVAR);
for i=1:NUM
    population(i,:)=0;
    population(i,1:6)=MAX_Salary*rand(1,6);
    %前半年不超过70%
    msum=sum(population(i,:));
    if msum>Money*0.7
        population(i,1:6)=population(i,1:6).*(Money*0.7/msum);
        msum=sum(population(i,:));
    end
    %分配后半个月
    for j=7:13
        population(i,j)=MAX_Salary*rand();
    end
    hsum=sum(population(i,7:12))+population(i,13)*12;%后半年和年终奖的钱数
    %调整和为20w
    m=(Money-msum)/hsum;
    population(i,7:13)=population(i,7:13).*m;
end


%计算适应度,即工资发放后投资到年底的总和
E=zeros(NUM,1);
for i=1:NUM
    E(i,1)=Eval(population(i,:));
end

%种群平均适应度
avfit=sum(E(:,1))/NUM;
%最优个体
bestone=population(1,:);
bestone_value=E(1,1);


generation=1;
%开始进化
while generation<=MAX_GEN
    
    %选择
    population=selection(population,E,avfit);    
    %交叉
    population=crossvoer(population);
    %变异
    population=mutation(population);
    
    for i=1:NUM
        st=sum(population(i,1:12))+population(i,13)*12;
        if st>Money
            population(i,:)=population(i,:).*(Money/st);
        end
    end
    %进化完成后,计算适应度
    for i=1:NUM
        E(i,1)=Eval(population(i,:));
    end
    %求种群的平均适应度
    avfit=sum(E(:,:))/NUM;
    %计算种群中的最优个体
    for i=1:NUM
        vtemp=E(i,1);
        if vtemp>bestone_value
            bestone_value=vtemp;
            bestone=population(i,:);
        end
    end
    %将各代种群保存下来
    Array(1,generation)=avfit;
    Array1(1,generation)=Eval(bestone);
    generation=generation+1;
end

figure(1);
plot(1:MAX_GEN,Array);
figure(2);
plot(1:MAX_GEN,Array1);

sum(bestone(1:12))+bestone(1,13)*12
bestone
Eval(bestone)
toc;






%种群变异操作
function out=mutation(p)
for mui=1:NUM
    if rand()<MigrationFraction
        %对每个基因进行变异
        k=zeros(1,13);
        k(1,1:6)=MAX_Salary.*rand(1,6);
        %前半年不超过70%
        musum=sum(k);
        if musum>halfM
            k(1,1:6)=k(1,1:6).*(halfM/musum);
            musum=halfM;
        end
        %分配后半个月
        k(1,7:13)=MAX_Salary.*rand(1,7);
        husum=sum(k(1,7:12))+k(1,13)*12;%后半年和年终奖的钱数
        %调整和为20w
        mu=(Money-musum)/husum;
        k(1,7:13)=k(1,7:13).*mu;
        p(mui,:)=k(1,:);
    end
end
out=p;
end

%种群交叉
function out=crossvoer(p)
for croi=1:NUM-1
    r=rand();
    if r<CrossvoerFraction
        %对两个个体进行交叉
        r1=ceil(rand()*11);
        r2=ceil(rand()*11);
        z1=p(croi,r1:r1+2);
        p(croi,r1:r1+2)=p(croi+1,r2:r2+2);
        p(croi+1,r2:r2+2)=z1;
        %限制前半年的工资
        csum=sum(p(croi,1:6));
        if csum>halfM
            p(croi,1:6)=p(croi,1:6).*(halfM/csum);
            csum=sum(p(croi,:));
        end
        %分配后半个月
        crsum=sum(p(croi,7:12))+p(croi,13)*12;%后半年和年终奖的钱数
        %调整和为20w
        mk=(Money-csum)/crsum;
        p(croi,7:13)=p(croi,7:13).*mk;
    end
end
out=p;
end



%种群选择
function out=selection(p,e,eav)
pop=ones(NUM,NVAR);
pop(1,:)=p(1,:);
for selei=2:NUM
    %根据个体的适应度选择
    if e(selei,1)>eav
    	pop(selei,:)=p(selei,:);
    else
        pop(selei,:)=pop(selei-1,:);
    end
end
out=pop;
end


%计算适应度
function out=Eval(s)
salary_at=zeros(NVAR,1);
ra=0.04;
%计算税后工资
for evi=1:NVAR
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
