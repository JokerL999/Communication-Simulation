%˥���ŵ��ı�������
clearvars; clc;close all
snrdB=-10:0.5:30; %���������ȷ�Χ��dBֵ
 
h= (randn(1,100) + 1i*randn(1,100) )/sqrt(2); %����ƽ˥��
sigma_z=1; 
 
snr = 10.^(snrdB/10); 
P=(sigma_z^2)*snr./(mean(abs(h).^2)); 
 
C_awgn=(log2(1+ snr));
C_fading=mean((log2(1+ ((abs(h).^2).')*P/(sigma_z^2))));

plot(snrdB,C_awgn,'b'); hold on; plot(snrdB,C_fading,'r'); grid on;
legend('AWGN�ŵ�����','˥���ŵ���������');
title('SISO˥���ŵ���������');
xlabel('SNR (dB)');ylabel('���� (bps/Hz)');