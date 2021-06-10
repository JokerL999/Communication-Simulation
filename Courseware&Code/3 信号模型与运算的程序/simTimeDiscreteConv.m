%一般序列的卷积计算演示
close all;clearvars;

n1=0:10;
x1=0.5*n1;
n2=-2:10;
x2=ones(1,length(n2));
[x,n]=TimeDiscreteConv(x1,n1,x2,n2)

subplot(3,1,1)
stem(n1,x1) %在子图 1 绘序列 x1[n]时域波形图
title('x_1[n]')
xlabel('n')
ylabel('x_1[n]')
subplot(3,1,2)
stem(n2,x2) %在图 2 绘序列 x2[n]时波形图
title('x_2[n]')
xlabel('n')
ylabel('x_2[n]')
subplot(3,1,3)
stem(n,x); %在子图 3 绘序列 x[n]的波形图
title('x_1[n]与 x_2[n]的卷积和 x[n]')
xlabel('n')
ylabel('x[n]')