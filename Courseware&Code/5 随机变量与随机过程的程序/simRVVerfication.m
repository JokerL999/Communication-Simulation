% 随机变量的验证
close all; clearvars;

lambda=1.5; 
L=1e5; 
T = exprnd(1/lambda,L,1);%simulating the RV

t_range=0:0.2:5;
T_pdf = lambda*exp(-lambda*t_range); %理论PDF
histogram(T,'Normalization','pdf'); hold on;%从数据中估计PDF
plot(t_range,T_pdf,'r');              % 绘制理论PDF
xlabel('t');ylabel('pdf - f_T(t)'); 
title(['指数分布PDF- \lambda=',num2str(lambda)]);
legend('仿真估计PDF','理论PDF');
fprintf('理论：均值[%2.2d]方差[%2.2d]\n',1/lambda,1/lambda^2)
fprintf('估计：均值[%2.2d]方差[%2.2d]\n',mean(T),var(T))
