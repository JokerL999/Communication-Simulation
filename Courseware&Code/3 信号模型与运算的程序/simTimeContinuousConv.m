%连续时间信号卷积的数值计算演示
close all;clearvars; clc;

p=0.01;
n1=0:p:2;
x1=0.5*n1;
n2=n1;
x2=x1;
[x,n]=TimeContinuousConv(x1,n1,x2,n2,p);

subplot(3,1,1)
plot(n1,x1) %在子图 1 绘序列 x1(k)时域波形图
title('x_1(t)')
xlabel('t')
ylabel('x_1(t)')
subplot(3,1,2)
plot(n2,x2) %在图 2 绘序列 x2(k)时波形图
title('x_2(t)')
xlabel('t')
ylabel('x_2(t)')
subplot(3,1,3)
plot(n,x); %在子图 3 绘序列 x(k)的波形图
title('x_1(t)与 x_2(t)的卷积和 x(t)')
xlabel('t')
ylabel('x(t)')

