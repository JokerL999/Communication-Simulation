% ��������ĺ���(���1)
close all; clearvars;

N=1e4;
x=rand(1,N);
y=-log(x);
histogram(y,'Normalization','pdf');

Y = 0:0.1:10; 
fY_theory =exp(-Y); %����PDF
hold on; plot(Y,fY_theory,'r-');       %��������PDF
title('�����ܶȺ���');legend('����','����');
xlabel('���ܵ�ȡֵ');ylabel('����');
