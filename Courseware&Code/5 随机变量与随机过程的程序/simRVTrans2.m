% ��������ĺ���(���2)
close all; clearvars;

N=100000;
x=6*rand(1,N)-1;
y=x.^2;
histogram(y,'Normalization','pdf');

Y = 0:0.1:30; 
fY_theory =1./(12*sqrt(Y));       %����PDF
hold on; plot(Y,fY_theory,'r-');  %��������PDF
title('�����ܶȺ���');legend('����','����');
xlabel('���ܵ�ȡֵ');ylabel('����');
