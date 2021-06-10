% 频率采样法设计FIR示例
clear all; clc; close all

Fs=1000;                         % 采样频率
halfFs=Fs/2;                     % 奈奎斯特频率
fp1=150; fp2=170;                % 通带频率
fs1=130; fs2=190;                % 阻带频率
deltaw=(fp1-fs1)*pi/halfFs;      % 过渡带宽Δω
M = ceil(6.6*pi/ deltaw);        % 按海明窗计算所需的滤波器阶数N
M = M + mod(M,2);                % 使滤波器阶数为偶数
f=[0 fs1 fp1 fp2 fs2 halfFs]/halfFs; % 通带和阻带的频率点归化值
m=[0 0 1 1 0 0];                 % 通带和阻带的频率点归化值

wind = (hamming(M+1))';          % 海明窗计算
b=fir2(M,f,m,wind);               % 用fir2函数设计FIR第1类滤波器

% 计算滤波器的频率响应
w=0:0.001:pi;                  
H=freqz(b,1,w);                  %滤波器响应
mag=abs(H);
db=20*log10((mag+eps)/max(mag)); %幅度的相对值 
pha=angle(H);                    %相位谱
grd=grpdelay(b,1,w);             %群时延

subplot 311;
plot(w*Fs/(2*pi),db,'k','linewidth',2);
title('(a)低通滤波器的幅值响应');
grid; xlabel('频率/Hz');  ylabel('幅值/dB')
set(gca,'XTickMode','manual','XTick',[0,130,150,170,190])

subplot 312;
plot(w*Fs/(2*pi),pha,'k','linewidth',2);
title('(b)低通滤波器的相位响应');
grid; xlabel('频率/Hz');  ylabel('相位/dB')

subplot 313; stem(1:M+1,b,'k');
xlabel('频率/Hz');  ylabel('幅值/dB')
title('(c)低通滤波器的脉冲响应');
xlabel('样点');  ylabel('幅值')

