function GA_GeneticAlgorithm()

%�Ŵ��㷨

%����
clc;
clear;
tic;

Money=200000;%���ʲ�Ϊ20w
halfM=140000;%ǰ���깤��
NUM=100;%��Ⱥ��ģ
MAX_GEN=2000;%����Ŵ�����
NVAR=13;%Ⱦɫ����Ŀ
CrossvoerFraction=0.2;%�������
MigrationFraction=0.2;%�������
MAX_Salary=40000;%��������ֵ
Array=zeros(1,MAX_GEN);%������ƽ��Ŀ��ֵ
Array1=zeros(1,MAX_GEN);%����������Ŀ��ֵ

%������ʼ��Ⱥ,ÿ��������13������
population=zeros(NUM,NVAR);
for i=1:NUM
    population(i,:)=0;
    population(i,1:6)=MAX_Salary*rand(1,6);
    %ǰ���겻����70%
    msum=sum(population(i,:));
    if msum>Money*0.7
        population(i,1:6)=population(i,1:6).*(Money*0.7/msum);
        msum=sum(population(i,:));
    end
    %���������
    for j=7:13
        population(i,j)=MAX_Salary*rand();
    end
    hsum=sum(population(i,7:12))+population(i,13)*12;%���������ս���Ǯ��
    %������Ϊ20w
    m=(Money-msum)/hsum;
    population(i,7:13)=population(i,7:13).*m;
end


%������Ӧ��,�����ʷ��ź�Ͷ�ʵ���׵��ܺ�
E=zeros(NUM,1);
for i=1:NUM
    E(i,1)=Eval(population(i,:));
end

%��Ⱥƽ����Ӧ��
avfit=sum(E(:,1))/NUM;
%���Ÿ���
bestone=population(1,:);
bestone_value=E(1,1);


generation=1;
%��ʼ����
while generation<=MAX_GEN
    
    %ѡ��
    population=selection(population,E,avfit);    
    %����
    population=crossvoer(population);
    %����
    population=mutation(population);
    
    for i=1:NUM
        st=sum(population(i,1:12))+population(i,13)*12;
        if st>Money
            population(i,:)=population(i,:).*(Money/st);
        end
    end
    %������ɺ�,������Ӧ��
    for i=1:NUM
        E(i,1)=Eval(population(i,:));
    end
    %����Ⱥ��ƽ����Ӧ��
    avfit=sum(E(:,:))/NUM;
    %������Ⱥ�е����Ÿ���
    for i=1:NUM
        vtemp=E(i,1);
        if vtemp>bestone_value
            bestone_value=vtemp;
            bestone=population(i,:);
        end
    end
    %��������Ⱥ��������
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






%��Ⱥ�������
function out=mutation(p)
for mui=1:NUM
    if rand()<MigrationFraction
        %��ÿ��������б���
        k=zeros(1,13);
        k(1,1:6)=MAX_Salary.*rand(1,6);
        %ǰ���겻����70%
        musum=sum(k);
        if musum>halfM
            k(1,1:6)=k(1,1:6).*(halfM/musum);
            musum=halfM;
        end
        %���������
        k(1,7:13)=MAX_Salary.*rand(1,7);
        husum=sum(k(1,7:12))+k(1,13)*12;%���������ս���Ǯ��
        %������Ϊ20w
        mu=(Money-musum)/husum;
        k(1,7:13)=k(1,7:13).*mu;
        p(mui,:)=k(1,:);
    end
end
out=p;
end

%��Ⱥ����
function out=crossvoer(p)
for croi=1:NUM-1
    r=rand();
    if r<CrossvoerFraction
        %������������н���
        r1=ceil(rand()*11);
        r2=ceil(rand()*11);
        z1=p(croi,r1:r1+2);
        p(croi,r1:r1+2)=p(croi+1,r2:r2+2);
        p(croi+1,r2:r2+2)=z1;
        %����ǰ����Ĺ���
        csum=sum(p(croi,1:6));
        if csum>halfM
            p(croi,1:6)=p(croi,1:6).*(halfM/csum);
            csum=sum(p(croi,:));
        end
        %���������
        crsum=sum(p(croi,7:12))+p(croi,13)*12;%���������ս���Ǯ��
        %������Ϊ20w
        mk=(Money-csum)/crsum;
        p(croi,7:13)=p(croi,7:13).*mk;
    end
end
out=p;
end



%��Ⱥѡ��
function out=selection(p,e,eav)
pop=ones(NUM,NVAR);
pop(1,:)=p(1,:);
for selei=2:NUM
    %���ݸ������Ӧ��ѡ��
    if e(selei,1)>eav
    	pop(selei,:)=p(selei,:);
    else
        pop(selei,:)=pop(selei-1,:);
    end
end
out=pop;
end


%������Ӧ��
function out=Eval(s)
salary_at=zeros(NVAR,1);
ra=0.04;
%����˰����
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
