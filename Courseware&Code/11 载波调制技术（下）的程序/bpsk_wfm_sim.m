% BPSK波形仿真
clearvars ; clc; close all
rng default

%% 参数设置
N=1e5   ;         %发送的符号数目
EbN0dB = -4:2:10; % 仿真的Eb/N0的dB范围
L=16;             %过采样因子
Fc=800;           %载频
Fs=L*Fc;          %采样频率

%% 发送信号调制与发射波形
ak = randi([0,1],N,1)>0.5;    %二进制数据流
[s_bb,t]= bpsk_mod(ak,L);     %基带调制信号
s = s_bb.*cos(2*pi*Fc*t/Fs);  %载波调制信号

subplot(2,2,1);plot(t,s_bb);%基带信号
xlabel('t(s)'); ylabel('s_{bb}(t)-baseband');xlim([0,10*L]);
subplot(2,2,2);plot(t,s);   %发射波形
xlabel('t(s)'); ylabel('s(t)-with carrier');xlim([0,10*L]);
%发射端星座
subplot(2,2,3);plot(real(s_bb),imag(s_bb),'o'); 
xlim([-1.5 1.5]); ylim([-1.5 1.5]); 

%% 接收波形检测
EbN0lin = 10.^(EbN0dB/10);
BER = zeros(length(EbN0dB),1); %仿真BER存储空间
for i=1:length(EbN0dB)
    Eb=L*sum(abs(s).^2)/length(s); %信号能量
    N0= Eb/EbN0lin(i); %计算噪声功率谱密度
    n = sqrt(N0/2)*randn(1,length(s));%生成噪声
    
    r = s + n;%通过噪声信道    
    r_bb = r.*cos(2*pi*Fc*t/Fs);%载波解调
    ak_cap = bpsk_demod(r_bb,L);%基带相关解调
    BER(i) = sum(ak~=ak_cap)/N; %SER/BER统计
    
    %接收信号波形
    subplot(2,2,4);plot(t,r);
    xlabel('t(s)'); ylabel('r(t)');xlim([0,10*L]);
 end
theoreticalBER = 0.5*erfc(sqrt(EbN0lin));%理论BER
%% 结果展示
figure;semilogy(EbN0dB,BER,'k*'); 
hold on;semilogy(EbN0dB,theoreticalBER,'r-');
xlabel('E_b/N_0 (dB)'); ylabel('BER - P_b');
legend('仿真', '理论');grid on;
title(['BPSK调制的BER']);