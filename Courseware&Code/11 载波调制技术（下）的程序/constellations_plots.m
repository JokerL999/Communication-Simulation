%星座绘制
clear all;clc;close all
rng default

%% 参数设置
N=1000;%发送的符号数目, 数量足够即可
fc=10; %载频
L=8;   %过采样因子

a = randi([0,1],N,1);       %二进制数据流

%% 使用 QPSK,OQPSK 和 MSK 调制信号
[s_qpsk,t_qpsk,I_qpsk,Q_qpsk]=qpsk_mod(a,fc,L);
[s_oqpsk,t_oqpsk,I_oqpsk,Q_oqpsk]=oqpsk_mod(a,fc,L);
[s_msk,t_msk,I_msk,Q_msk] = msk_mod(a,fc,L);

%构造升余弦滤波器
alpha = 0.3; % 升余弦滤波器alpha参数
Nsym = 10;   % 滤波器的符号跨度
rcPulse = raisedCosineFunction(alpha,L,Nsym);%升余弦滤波器函数

%不同调制信号的I路和Q路信号通过成型滤波器
iRC_qpsk = conv(I_qpsk,rcPulse,'same');  %成型滤波后的I路QPSK信号
qRC_qpsk = conv(Q_qpsk,rcPulse,'same');  %成型滤波后的Q路QPSK信号
iRC_oqpsk = conv(I_oqpsk,rcPulse,'same');%成型滤波后的I路OQPSK信号
qRC_oqpsk = conv(Q_oqpsk,rcPulse,'same');%成型滤波后的Q路OQPSK信号

%% 画星座
subplot(1,3,1);plot(iRC_qpsk,qRC_qpsk); %QPSK星座
title('QPSK, RC \alpha=0.3');xlabel('I(t)');ylabel('Q(t)');
subplot(1,3,2);plot(iRC_oqpsk,qRC_oqpsk); %OQPSK星座
title('O-QPSK, RC \alpha=0.3');xlabel('I(t)');ylabel('Q(t)');
subplot(1,3,3);plot(I_msk(20:end-20),Q_msk(20:end-20)); %MSK信号星座
title('MSK');xlabel('I(t)');ylabel('Q(t)');