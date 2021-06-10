% 最优等波纹法设计FIR示例
clear all; clc; close all;

Fs=2000;                          % 采样频率
halfFs=Fs/2;                      % 奈奎斯特频率
fp=200; fs=300;                   % 通带和阻带频率
wp=fp*pi/halfFs; ws=fs*pi/halfFs; % 通带和阻带归一化角频率
Rp=2; As=40;                      % 通带波纹和阻带衰减
F=[wp ws]/pi;                     % 理想滤波器的频率矢量
A=[1,0];                          % 理想滤波器的幅值矢量

% 通带波纹和阻带衰减线性值
dev1=(1-10^(-Rp/20))/(1+10^(-Rp/20)); dev2=10^(-As/20); %通带和阻带偏差
dev=[dev1,dev2];                  % 与理想滤波器的偏差的矢量

[N,F0,A0,W]=firpmord(F,A,dev);    % 调用firpmord函数计算参数
N=N+mod(N,2);                     % 保证滤波器阶数为偶数
b=firpm(N,F0,A0,W);               % 用firpm函数设计滤波器

% 计算滤波器频域响应
w=0:0.001:pi;                  
H=freqz(b,1,w);                  %滤波器响应
mag=abs(H);
db=20*log10((mag+eps)/max(mag)); %幅度的相对值 
pha=angle(H);                    %相位谱
grd=grpdelay(b,1,w);             %群时延

% 作图
subplot 211; plot(w/pi*halfFs,db,'k','linewidth',2); 
title('等波纹滤波器幅值响应'); 
grid;xlabel('频率/kHz'); ylabel('幅值/dB')
set(gca,'XTickMode','manual','XTick',[0,fp,fs,halfFs])
set(gca,'YTickMode','manual','YTick',[-40,0])
subplot 212; stem(0:N,b,'k'); axis([-1,N,-0.1,0.3]); grid;
title('滤波器脉冲响应');xlabel('样点'); ylabel('幅值');
