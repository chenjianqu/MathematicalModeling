a=linspace(1,10,5);%在1-10中生成5个元素的向量
save E:\Mathlab\数学建模国赛\txt_test.txt a -ascii;%把a以ascii码的形式保存为txt文件
b=load('E:\Mathlab\数学建模国赛\txt_test.txt');%读入txt中的内容
b

%txt中含有多种类型的数据，用textread或textsacn,建议用后者
[name,age,weight]=textread('E:\Mathlab\数学建模国赛\txt_test_textread.txt','%s %d %f',2,'headerlines',0);%2表示读取两行，headerlines 1表示从第0+1开始读




