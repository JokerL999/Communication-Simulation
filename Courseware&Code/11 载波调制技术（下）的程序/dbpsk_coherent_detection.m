% 差分编码BPSK调制的相关检测
clear all;clc;close all
rng default

%% 参数设置
N=1e5   ;         %发送的符号数目
EbN0dB = -4:2:10; % 仿真的Eb/N0的dB范围
L=16;             %过采样因子
Fc=800;           %载频
Fs=L*Fc;          %采样频率

EbN0lin = 10.^(EbN0dB/10); 
EsN0dB=10*log10(1)+EbN0dB; 
EsN0lin = 10.^(EsN0dB/10);
SER = zeros(length(EbN0dB),1);

%% 发送信号调制与发射波形
ak = randi([0,1],N,1);       %二进制数据流
bk = filter(1,[1 -1],ak,0);  %IIR差分编码
bk = mod(bk,2);              %模2运算
[s_bb,t]= bpsk_mod(bk,L);    %基带BPSK调制
s = s_bb.*cos(2*pi*Fc*t/Fs); %载波调制

%% 接收波形检测
for i=1:length(EbN0dB)
    Esym=sum(abs(s).^2)/length(s); %信号能量
    N0= Esym/EsN0lin(i); %计算功率谱密度
    n=sqrt(L*N0/2)*(randn(1,length(s))+1i*randn(1,length(s)));
    r = s + n;%通过AWGN信道
    
    phaseAmbiguity=pi;     %模拟Costas环导致的180°相位模糊
    r_bb=r.*cos(2*pi*Fc*t/Fs+phaseAmbiguity);%载波解调
    b_cap=bpsk_demod(r_bb,L);%基带相关解调
    a_cap=filter([1 1],1,b_cap); %FIR差分解吗
    a_cap= mod(a_cap,2); %模2运算    
    SER(i) = sum(ak~=a_cap)/N;%SER统计  
end
theorySER_DPSK = erfc(sqrt(EbN0lin)).*(1-0.5*erfc(sqrt(EbN0lin)));
theorySER_BPSK = 0.5*erfc(sqrt(EbN0lin));

%% 结果展示
figure;semilogy(EbN0dB,SER,'k*'); hold on;
semilogy(EbN0dB,theorySER_DPSK,'r-');
semilogy(EbN0dB,theorySER_BPSK,'b-');
title('AWGN信道下差分编码BPSK信号的相关检测性能');
xlabel('E_b/N_0 (dB)');ylabel('BER - P_b');
legend('相关检测 DBPSK(仿真)','相关检测 DBPSK(理论）','传统BPSK')