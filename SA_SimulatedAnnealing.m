%ģ���˻��㷨

%0-1��������:��12����Ʒ�����������������Ϊ46��������ߵĶ�����ֵǮ
clear;
clc;
a=0.95;%�¶�T��˥��ϵ��
k=[5;10;13;4;3;11;13;10;8;16;7;4];%������Ʒ�ļ�ֵ
k=-k;%ģ���˻��㷨�������Сֵ������Ҫ�����ֵ����ȡ����
d=[2;5;18;3;2;5;10;4;11;7;14;6];%����Ʒ������
restriction=46;%���ֵ
num=12;%12����Ʒ
sol_new=ones(1,num);%������ʼ��
E_current=inf;%��ǰ���Ӧ��Ŀ�꺯��ֵ
E_best=inf;%��ȴ�����е��ҵ������Ž�
sol_current=sol_new;%��ǰ��
sol_best=sol_new;%��ȴ�����е��ҵ������Ž�
t0=97;
tf=3;
t=t0;
p=1;

while t>=tf
    for r=1:100
        %��������Ŷ�
        tmp=ceil(rand.*num);%ceil�������������ȡ��,tmp��1-12��Χ��
        sol_new(1,tmp)=~sol_new(1,tmp);%��ĳ����Ʒ����
        
        %����Ƿ�����Լ��
        while 1
            q=(sol_new*d<=restriction);%�²���ѡ���Ƿ���46����Χ��
            if ~q%�������
                p=~p;
                tmp=find(sol_new==1);%����sol_new��Ԫ�ص���1��λ��
                if p
                    sol_new(1,tmp)=1;
                else
                    sol_new(1,tmp(end))=0;%tmp(end)��ʾtmp�����һ��Ԫ�ص�ֵ
                end
            else%����������������ѭ��
                break;
            end
        end
        
        %���㱳���е���Ʒ��ֵ
        E_new=sol_new*k;
        %����½��ֵ���ڵ�ǰ��
        if E_new<E_current
            E_current=E_new;
            sol_current=sol_new;
            if E_new<E_best
                %����ȴ������õĽⱣ������
                E_best=E_new;
                sol_best=sol_new;
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

disp('���Ž�Ϊ��');
sol_best
disp('��Ʒ�ܼ�ֵΪ��');
-E_best
disp('��������Ʒ������Ϊ��');
sol_best*d

