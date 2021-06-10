%衰落信道的遍历容量
clearvars; clc;close all
snrdB=-10:0.5:30; %仿真的信噪比范围，dB值
 
h= (randn(1,100) + 1i*randn(1,100) )/sqrt(2); %瑞利平衰落
sigma_z=1; 
 
snr = 10.^(snrdB/10); 
P=(sigma_z^2)*snr./(mean(abs(h).^2)); 
 
C_awgn=(log2(1+ snr));
C_fading=mean((log2(1+ ((abs(h).^2).')*P/(sigma_z^2))));

plot(snrdB,C_awgn,'b'); hold on; plot(snrdB,C_fading,'r'); grid on;
legend('AWGN信道容量','衰落信道遍历容量');
title('SISO衰落信道遍历容量');
xlabel('SNR (dB)');ylabel('容量 (bps/Hz)');