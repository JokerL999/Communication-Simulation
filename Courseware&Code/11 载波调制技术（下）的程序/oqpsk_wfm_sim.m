%OQPSK波形仿真
clear all;clc;close all
rng default

%% 参数设置
N=1e5   ;         %发送的符号数目
EbN0dB = -4:2:10; %仿真的Eb/N0的dB范围
fc=100;           %载频[Hz]
OF =8;            %过采样因子 fs=OF*fc

EbN0lin = 10.^(EbN0dB/10); 
BER = zeros(length(EbN0dB),1); 

a = randi([0,1],N,1);       %二进制数据流
[s,t] = oqpsk_mod(a,fc,OF); %OQPSK 调制

for i=1:length(EbN0dB)  
    Eb=OF*sum(abs(s).^2)/(length(s)); %计算信号能量
    N0= Eb/EbN0lin(i); %噪声功率谱
    n = sqrt(N0/2)*(randn(1,length(s)));%生成噪声
    r = s + n;                     %通过AWGN信道
    a_cap = oqpsk_demod(r,N,fc,OF); %QPSK解调
    BER(i) = sum(a~=a_cap)/N;  %BER统计
end
theoreticalBER = 0.5*erfc(sqrt(EbN0lin));%理论BER

%% 结果展示
figure;semilogy(EbN0dB,BER,'k*','LineWidth',1.5); %simulated BER
hold on; semilogy(EbN0dB,theoreticalBER,'r-','LineWidth',1.5);
title('OQPSK调制性能');
xlabel('E_b/N_0 (dB)');ylabel('BER - P_b');
legend('仿真', '理论');grid on;