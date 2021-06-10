clear all; clc; close all;
 
fs=400;                                 % 采样频率
N=400;                                  % 数据长度
n=0:1:N-1;
dt=1/fs;
t=n*dt;                                 % 时间序列
A=0.5;                                  % 相位调制幅值
x=(1+0.5*cos(2*pi*5*t)).*cos(2*pi*50*t+A*sin(2*pi*10*t));  % 信号序列
z=hilbert(x');                          % 希尔伯特变换
a=abs(z);                               % 包络线
xL=z.*exp(-1i*2*pi*50*t');              % 等效低通信号

[Xf, f] = SpectrumViewer(x,fs, 'twosided');   %带通信号的频谱
[Zf, f] = SpectrumViewer(z,fs, 'twosided');   %解析信号的频谱
[XLf, f] = SpectrumViewer(xL,fs, 'twosided'); %等效低通信号的频谱
% 作图
figure	
subplot(211)
plot(t, x);xlabel('t');ylabel('时域幅度');title('时域信号')
subplot(212)
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1), pos(2)-100,pos(3),pos(4)]);
plot(t,x,'k'); hold on;
plot(t,a,'r--','linewidth',2);
title('包络线'); ylabel('幅值'); xlabel(['时间/s' 10 '(a)']);
figure
subplot(311)
plot(f, abs(Xf));xlabel('f');ylabel('幅度谱');title('带通信号的频谱')
subplot(312)
plot(f, abs(Zf));xlabel('f');ylabel('幅度谱');title('解析信号的频谱')
subplot(313)
plot(f, abs(XLf));xlabel('f');ylabel('幅度谱');title('等效低通信号的频谱')

