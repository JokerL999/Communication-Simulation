% ������˹˥���ŵ�
clearvars;close all; clc;

N= 10^5; %��������������
KdB_factors = [-10 0 5 10]; %��˹K����

for KdB=KdB_factors
  K=10^(KdB/10);
  r = RiceChannel(K,N);
  figure
  histogram(abs(r),'Normalization','pdf');
 
  x = 0:0.05:3;
  Omega=1; %�ܹ��ʣ���Ϊ1
  z = 2*x*sqrt(K*(K+1)/Omega);
  I0_z= besseli(0,z);%��һ��0�������ı���������
  pdf = (2*x*(K+1)/Omega).*exp(-K-(x.^2*(K+1)/Omega)).*I0_z; %����PDF 
  hold on; plot(x,pdf);
  title(['��˹PDF-K=',num2str(KdB),'dB']);
  xlabel('x');ylabel('f_{\xi}(x)');axis tight; grid on;
end