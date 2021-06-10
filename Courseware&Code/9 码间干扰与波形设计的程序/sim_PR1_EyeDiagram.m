close all; clearvars;
rng default;

N = 1e5; % 发送的符号数目
M = 2;   %调制阶数
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
Nsym=8 ;%滤波器跨度（以符号为单位，持续时间,-Nsym/2~Nsym/2）
Q=[1 1]; %PR Class I Duobinary scheme
[b,t]=PRSignaling(Q,L,Nsym);% 部分响应的冲激响应
filtDelay=(length(b)-1)/2; %FIR filter delay
s=conv(v,b,'full');%Convolve modulated syms with p[n] filter
figure; plot(real(s),'r'); title('成形滤波后的信号波形 s(n)');
xlim([0,30*L])

figure;
plotEyeDiagram(s,L,6*L,2*filtDelay,100);



