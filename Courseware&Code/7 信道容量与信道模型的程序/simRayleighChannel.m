% 包络瑞利衰落信道
clearvars;close all; clc;
rng default;

N=1e5;     %随机生成样点个数
sigma=1;
T=RayleighChannel(sigma,N);
histogram(abs(T),'Normalization','pdf'); hold on;%从数据中估计PDF

t_range = 0:0.1:10; 
T_pdf = (t_range/sigma^2).*exp(-t_range.^2/(2*sigma^2));%理论PDF
hold on; plot(t_range,T_pdf,'k'); grid on;

plot(t_range,T_pdf,'r');              
xlabel('t');ylabel('pdf - f_T(t)'); 
title(['瑞利PDF-\sigma=',num2str(sigma)]);
legend('仿真估计PDF','理论PDF');