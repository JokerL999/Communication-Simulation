%һ�����еľ��������ʾ
close all;clearvars;

n1=0:10;
x1=0.5*n1;
n2=-2:10;
x2=ones(1,length(n2));
[x,n]=TimeDiscreteConv(x1,n1,x2,n2)

subplot(3,1,1)
stem(n1,x1) %����ͼ 1 ������ x1[n]ʱ����ͼ
title('x_1[n]')
xlabel('n')
ylabel('x_1[n]')
subplot(3,1,2)
stem(n2,x2) %��ͼ 2 ������ x2[n]ʱ����ͼ
title('x_2[n]')
xlabel('n')
ylabel('x_2[n]')
subplot(3,1,3)
stem(n,x); %����ͼ 3 ������ x[n]�Ĳ���ͼ
title('x_1[n]�� x_2[n]�ľ���� x[n]')
xlabel('n')
ylabel('x[n]')