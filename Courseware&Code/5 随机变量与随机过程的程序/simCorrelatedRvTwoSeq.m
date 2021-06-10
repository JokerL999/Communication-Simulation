%�������������е�����ʾ��
clearvars;close all;clc;
rng default

N=1000;         %���г���
x1=randn(1,N); %��̬�ֲ��������1
x2=randn(1,N); %��̬�ֲ��������2
subplot(1,2,1); plot(x1,x2,'r*');
title('������������ X_1 �� X_2');
xlabel('X_1'); ylabel('X_2')
axis([-4,4,-4,4])

rho=0.9;
z=rho*x1+sqrt(1-rho^2)*x2;
subplot(1,2,2); plot(x1,z,'r*');
title(['���������� X_1 �� Z , \rho=',num2str(rho)]);
xlabel('X_1'); ylabel('Z');
axis([-4,4,-4,4])
