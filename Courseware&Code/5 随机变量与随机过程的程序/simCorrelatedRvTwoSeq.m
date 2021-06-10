%两个相关随机序列的生成示例
clearvars;close all;clc;
rng default

N=1000;         %序列长度
x1=randn(1,N); %正态分布随机序列1
x2=randn(1,N); %正态分布随机序列2
subplot(1,2,1); plot(x1,x2,'r*');
title('不相关随机序列 X_1 和 X_2');
xlabel('X_1'); ylabel('X_2')
axis([-4,4,-4,4])

rho=0.9;
z=rho*x1+sqrt(1-rho^2)*x2;
subplot(1,2,2); plot(x1,z,'r*');
title(['相关随机序列 X_1 和 Z , \rho=',num2str(rho)]);
xlabel('X_1'); ylabel('Z');
axis([-4,4,-4,4])
