% 窗函数法设计FIR示例
clear all; clc; close all

Fs=100;                          % 采样频率
halfFs=Fs/2;                     % 奈奎斯特频率
fp=3; fs=5;                      % 通带和阻带频率
Rp=3; As=50;                     % 通带波纹和阻带衰减
wp = fp*pi/halfFs;               % 通带归一化角频率
ws = fs*pi/halfFs;               % 阻带归一化角频率
deltaw= ws - wp;                 % 过渡带宽Δω的计算
M = ceil(6.6*pi/ deltaw);        % 按海明窗计算所需的滤波器阶数N
M = M + mod(M,2);                % 使滤波器阶数为偶数
wind = (hamming(M+1))';          % 海明窗计算
Wn=(fp+fs)/Fs;                   % 计算截止频率
b=fir1(M,Wn,wind);               % 用fir1函数设计FIR第1类滤波器

% 计算滤波器的频率响应
w=0:0.001:pi;                  
H=freqz(b,1,w);                  %滤波器响应
mag=abs(H);
db=20*log10((mag+eps)/max(mag)); %幅度的相对值 
pha=angle(H);                    %相位谱
grd=grpdelay(b,1,w);             %群时延

% 作图
subplot 311;
plot(w*Fs/(2*pi),db,'k','linewidth',2);
title('(a)低通滤波器的幅值响应');
grid; xlabel('频率/Hz');  ylabel('幅值/dB')
set(gca,'XTickMode','manual','XTick',[0,3,5,50])

subplot 312;
plot(w*Fs/(2*pi),pha,'k','linewidth',2);
title('(b)低通滤波器的相位响应');
grid; xlabel('频率/Hz');  ylabel('相位/dB')

subplot 313; stem(1:M+1,b,'k');
xlabel('频率/Hz');  ylabel('幅值/dB')
title('(c)低通滤波器的脉冲响应');
xlabel('样点');  ylabel('幅值')

