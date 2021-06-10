% ��������˥���ŵ�
clearvars;close all; clc;
rng default;

N=1e5;     %��������������
sigma=1;
T=RayleighChannel(sigma,N);
histogram(abs(T),'Normalization','pdf'); hold on;%�������й���PDF

t_range = 0:0.1:10; 
T_pdf = (t_range/sigma^2).*exp(-t_range.^2/(2*sigma^2));%����PDF
hold on; plot(t_range,T_pdf,'k'); grid on;

plot(t_range,T_pdf,'r');              
xlabel('t');ylabel('pdf - f_T(t)'); 
title(['����PDF-\sigma=',num2str(sigma)]);
legend('�������PDF','����PDF');