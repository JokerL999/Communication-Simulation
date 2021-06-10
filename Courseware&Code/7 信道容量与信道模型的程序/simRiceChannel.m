% 包络莱斯衰落信道
clearvars;close all; clc;

N= 10^5; %随机生成样点个数
KdB_factors = [-10 0 5 10]; %莱斯K因子

for KdB=KdB_factors
  K=10^(KdB/10);
  r = RiceChannel(K,N);
  figure
  histogram(abs(r),'Normalization','pdf');
 
  x = 0:0.05:3;
  Omega=1; %总功率，设为1
  z = 2*x*sqrt(K*(K+1)/Omega);
  I0_z= besseli(0,z);%第一类0阶修正的贝塞尔函数
  pdf = (2*x*(K+1)/Omega).*exp(-K-(x.^2*(K+1)/Omega)).*I0_z; %理论PDF 
  hold on; plot(x,pdf);
  title(['莱斯PDF-K=',num2str(KdB),'dB']);
  xlabel('x');ylabel('f_{\xi}(x)');axis tight; grid on;
end