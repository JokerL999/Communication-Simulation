%����ʱ���źž������ֵ������ʾ
close all;clearvars; clc;

p=0.01;
n1=0:p:2;
x1=0.5*n1;
n2=n1;
x2=x1;
[x,n]=TimeContinuousConv(x1,n1,x2,n2,p);

subplot(3,1,1)
plot(n1,x1) %����ͼ 1 ������ x1(k)ʱ����ͼ
title('x_1(t)')
xlabel('t')
ylabel('x_1(t)')
subplot(3,1,2)
plot(n2,x2) %��ͼ 2 ������ x2(k)ʱ����ͼ
title('x_2(t)')
xlabel('t')
ylabel('x_2(t)')
subplot(3,1,3)
plot(n,x); %����ͼ 3 ������ x(k)�Ĳ���ͼ
title('x_1(t)�� x_2(t)�ľ���� x(t)')
xlabel('t')
ylabel('x(t)')

