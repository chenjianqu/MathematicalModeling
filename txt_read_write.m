a=linspace(1,10,5);%��1-10������5��Ԫ�ص�����
save E:\Mathlab\��ѧ��ģ����\txt_test.txt a -ascii;%��a��ascii�����ʽ����Ϊtxt�ļ�
b=load('E:\Mathlab\��ѧ��ģ����\txt_test.txt');%����txt�е�����
b

%txt�к��ж������͵����ݣ���textread��textsacn,�����ú���
[name,age,weight]=textread('E:\Mathlab\��ѧ��ģ����\txt_test_textread.txt','%s %d %f',2,'headerlines',0);%2��ʾ��ȡ���У�headerlines 1��ʾ�ӵ�0+1��ʼ��




