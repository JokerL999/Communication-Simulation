% �����������֤
close all; clearvars;

lambda=1.5; 
L=1e5; 
T = exprnd(1/lambda,L,1);%simulating the RV

t_range=0:0.2:5;
T_pdf = lambda*exp(-lambda*t_range); %����PDF
histogram(T,'Normalization','pdf'); hold on;%�������й���PDF
plot(t_range,T_pdf,'r');              % ��������PDF
xlabel('t');ylabel('pdf - f_T(t)'); 
title(['ָ���ֲ�PDF- \lambda=',num2str(lambda)]);
legend('�������PDF','����PDF');
fprintf('���ۣ���ֵ[%2.2d]����[%2.2d]\n',1/lambda,1/lambda^2)
fprintf('���ƣ���ֵ[%2.2d]����[%2.2d]\n',mean(T),var(T))
