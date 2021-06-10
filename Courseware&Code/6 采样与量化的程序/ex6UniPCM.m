clear all;
close all; 
clc; 

t=0:0.1:20;
wav=sin(t);

figure;
plot(wav,'r'); 
hold on 

[sqnr,wav_riser]=UniPcm(wav,8);
sqnr

% ��������֮�������
plot(wav_riser,'b')
title('��������');
hold off 

function [sqnr,x_qtz]=UniPcm(x,n)
% x�����ź�
% n������ƽ����

xmax=max(abs(x));
x_qtz=x/xmax;
delta=2/n;
q=delta*[0:n-1]-(n-1)/2*delta;

for i=1:n
    index=find((q(i)-delta/2<=x_qtz)&(x_qtz<=q(i)+delta/2));%�ҳ����в�Ϊ���λ��
    x_qtz(index)=q(i)*ones(1,length(index));%��Ӧλ��������������ƽ
end

x_qtz=x_qtz*xmax;
sqnr=20*log10(norm(x)./norm(x-x_qtz));
end
