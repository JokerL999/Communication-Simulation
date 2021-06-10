% 随机变量的函数(情况2)
close all; clearvars;

N=100000;
x=6*rand(1,N)-1;
y=x.^2;
histogram(y,'Normalization','pdf');

Y = 0:0.1:30; 
fY_theory =1./(12*sqrt(Y));       %理论PDF
hold on; plot(Y,fY_theory,'r-');  %绘制理论PDF
title('概率密度函数');legend('仿真','理论');
xlabel('可能的取值');ylabel('概率');
