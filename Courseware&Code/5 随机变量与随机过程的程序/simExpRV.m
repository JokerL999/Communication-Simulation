% �任������ָ���ֲ��������
close all; clearvars;

lambda=1.5; 
L=1e4; 
x = expRV(lambda,L);%�����������
t_range=0:0.2:5;
T_pdf = lambda*exp(-lambda*t_range); %����PDF
histogram(x,'Normalization','pdf'); hold on;%�������й���PDF
plot(t_range,T_pdf,'r'); %���Ʒ������PDF
xlabel('x');ylabel('pdf - f_X(x)'); 
title(['ָ���ֲ�PDF:\lambda=',num2str(lambda)]);
legend('����','����');

function x = expRV(lambda,L)
%�任������ָ���ֲ��������
%lambda - ָ���ֲ��Ĳ���, L - ���ݳ���
u = rand(1,L); %���ȷֲ��������
x = -1/lambda*(log(1-u));
end