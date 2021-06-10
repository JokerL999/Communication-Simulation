%% 差分BPSK的非相干检测
clear all;clc;close all
rng default

%% 参数设置
N=1e5   ;         %发送的符号数目
EbN0dB = -4:2:10; % 仿真的Eb/N0的dB范围
L=8;              %过采样因子
Fc=800;           %载频
Fs=L*Fc;          %采样频率

EbN0lin = 10.^(EbN0dB/10); 
BER_suboptimum = zeros(length(EbN0dB),1);

%% 发送信号调制与发射波形
a = randi([0,1],N,1);       %二进制数据流
b = filter(1,[1 -1],a,0);  %IIR差分编码
b = mod(b,2);              %模2运算
[s_bb,t]= bpsk_mod(b,L);    %基带BPSK调制
s = s_bb.*cos(2*pi*Fc*t/Fs); %载波调制

%% 接收波形检测
for i=1:length(EbN0dB)
    Esym=L*sum(abs(s).^2)/length(s); %信号能量
    N0= Esym/EbN0lin(i); %计算功率谱密度
    n=sqrt(N0/2)*(randn(1,length(s))+1i*randn(1,length(s)));%noise
    
    r = s + n;%通过AWGN信道  
    p=real(r).*cos(2*pi*Fc*t/Fs);%利用带通滤波器解调到基带    
    w0=[p zeros(1,L)];%在序列尾部补L个0
    w1=[zeros(1,L) p];%在序列头加L个0
    w = w0.*w1;%时延后相乘
    z = conv(w,ones(1,L));%积分
    u = z(L:L:end-L);     % t=kTb时刻上采样
    a_cap = u.'<0;        % 判决
    BER_suboptimum(i) = sum(a~=a_cap)/N;%BER统计   
end
%理论BER和SER
theory_DBPSK_suboptimum = 0.5.*exp(-0.76*EbN0lin);
theory_DBPSK_coherent=erfc(sqrt(EbN0lin)).*(1-0.5*erfc(sqrt(EbN0lin)));
theory_BPSK_conventional = 0.5*erfc(sqrt(EbN0lin));

%% 结果展示
figure;semilogy(EbN0dB,BER_suboptimum,'k*','LineWidth',1.0);
hold on;
semilogy(EbN0dB,theory_DBPSK_suboptimum,'m-','LineWidth',1.0);
semilogy(EbN0dB,theory_DBPSK_coherent,'k-','LineWidth',1.0);
semilogy(EbN0dB,theory_BPSK_conventional,'b-','LineWidth',1.0);
set(gca,'XLim',[-4 12]);set(gca,'YLim',[1E-6 1E0]);
set(gca,'XTick',-4:2:12);title('差分BPSK非相干检测性能');
xlabel('E_b/N_0 (dB)');ylabel('BER - P_b');
legend('DBPSK 次优 (仿真)','DBPSK 次优 (理论)','相干 DEBPSK','相干 BPSK');