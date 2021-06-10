close all; clearvars;
rng default;


N = 1e5; % 发送的符号数目
M = 4;   %调制阶数
d = ceil(M.*rand(1,N)); %生成随机符号

% PAM调制
u = mpam_modulator(M,d);%MPAM调制
figure; 
stem(real(u)); 
xlim([0,20])
ylim([-5,5])
title('PAM调制信号u[k]');

% 上采样
L=4; % 过采样因子
v=[u;zeros(L-1,length(u))];%每个样点之间插L-1个零
v=v(:).';
figure
stem(real(v)); 
title('过采样信号v(n)');
xlim([0,30*L])
ylim([-5,5])

% 成型滤波
beta = 0.3;% 滚降因子
Nsym=8 ;%滤波器跨度（以符号为单位，持续时间,-Nsym/2~Nsym/2）
[p,t] = srrcFunction(beta,L,Nsym);%平方根升余弦滤波器函数
filtDelay=(length(p)-1)/2; %FIR filter delay
s=conv(v,p,'full');%Convolve modulated syms with p[n] filter
figure; plot(real(s),'r'); title('成形滤波后的信号波形 s(n)');
xlim([0,30*L])


% 通过信道
EbN0dB = 10; %信道的比特信噪比dB值
snr = 10*log10(log2(M))+EbN0dB; %将Eb/N0转成SNR
r = add_awgn_noise(s,snr,L); %通过AWGN信道
figure; plot(real(r),'r');title('接收信号 r(n)');
xlim([0,30*L])

vCap=conv(r,p,'full');%接收匹配滤波
figure; 
plot(real(vCap),'r');
title('匹配滤波后');
xlim([0,30*L])
%匹配滤波后画眼图
figure;
plotEyeDiagram(vCap,L,3*L,2*filtDelay,100);

% 符号率采样，下采样
uCap = vCap(2*filtDelay+1:L:end-(2*filtDelay))/L;
figure; stem(real(uCap)); hold on;
xlim([0,30])
title('下采样后');
dCap = mpam_detector(M,uCap); %解调

