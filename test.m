%������ʼ��Ⱥ,ÿ��������13������
clc;
clear;
tic;

Money=200000;%���ʲ�Ϊ20w
NUM=5;%��Ⱥ��ģ
MAX_GEN=10;%����Ŵ�����
NVAR=13;%Ⱦɫ����Ŀ
CrossvoerFraction=0.5;%�������
MigrationFraction=0.2;%�������
MAX_Salary=40000;%��������ֵ
Array=zeros(1,MAX_GEN);%������ƽ��Ŀ��ֵ

NUM=50;
NVAR=13;

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
p=population;
sum(population(6,1:6))
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
        if csum>Money*0.7
            p(croi,1:6)=p(croi,1:6).*(Money*0.7/csum);
            csum=sum(p(croi,:));
        end
        %���������
        crsum=sum(p(croi,7:12))+p(croi,13)*12;%���������ս���Ǯ��
        %������Ϊ20w
        mk=(Money-csum)/crsum;
        p(croi,7:13)=p(croi,7:13).*mk;
    end
end


for mui=1:50
    r=rand();
    if r<MigrationFraction
        %��ÿ��������б���
        p(mui,:)=0;
        p(mui,1:6)=MAX_Salary*rand(1,6);
        %ǰ���겻����70%
        musum=sum(p(mui,:));
        if musum>Money*0.7
            p(mui,1:6)=p(mui,1:6).*(Money*0.7/musum);
            musum=sum(p(mui,:));
        end
        %���������
        for muj=7:13
            p(mui,muj)=MAX_Salary*rand();
        end
        husum=sum(p(mui,7:12))+p(mui,13)*12;%���������ս���Ǯ��
        %������Ϊ20w
        mu=(Money-musum)/husum;
        p(mui,7:13)=p(mui,7:13).*mu;
    end
end
out=p


population
sum(population(6,1:6))
sum(population(6,1:12))+sum(population(6,13))*12