% 变换法生成指数分布随机变量
close all; clearvars;

lambda=1.5; 
L=1e4; 
x = expRV(lambda,L);%生成随机变量
t_range=0:0.2:5;
T_pdf = lambda*exp(-lambda*t_range); %理论PDF
histogram(x,'Normalization','pdf'); hold on;%从数据中估计PDF
plot(t_range,T_pdf,'r'); %绘制仿真估计PDF
xlabel('x');ylabel('pdf - f_X(x)'); 
title(['指数分布PDF:\lambda=',num2str(lambda)]);
legend('仿真','理论');

function x = expRV(lambda,L)
%变换法生成指数分布随机变量
%lambda - 指数分布的参数, L - 数据长度
u = rand(1,L); %均匀分布随机变量
x = -1/lambda*(log(1-u));
end