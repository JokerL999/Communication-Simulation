% 用FFT对一个正弦信号进行频谱分析
clear all; clc; close all;

fs=100;                          % 采样频率
N=100;                           % 信号长度
t=(0:N-1)/fs;                    % 设置时间序列
f1=25;                           % 信号频率

x=0.8+2*cos(2*pi*f1*t+pi/6);       % 信号采样
X=fft(x);                        % FFT

% 单边谱
Y=zeros(1,N);
freq=(0:N/2-1)*fs/N;             % 设置频率刻度
Y(1)=abs(X(1))/N;                % 直流分量的幅度调整
Y(2:end)=abs(X(2:end))*2/N;      % 计算幅值
Theta=angle(X);                  % 计算相位

%消除相位噪声
Th=0.1;                        % 设置阈值
thetadex=find(Y<Th);          % 寻找小于阈值的那线谱线的索引
Theta(thetadex)=0;            % 对于小于阈值的那线谱线初始相位都为0

subplot 221; plot(freq,Y(1:N/2),'k');  
xlabel('频率/Hz'); ylabel('幅值'); title('单边谱');
subplot 223; plot(freq,Theta(1:N/2),'k');
xlabel('频率/Hz'); ylabel('初始角/弧度'); title('相位');

% 双边谱
freq=(0:N-1)*fs/N-fs/2;                % 设置频率刻度
Y=fftshift(abs(X)/N);                  % 计算幅值
subplot 222; plot(freq,Y,'k');  
xlabel('频率/Hz'); ylabel('幅值'); title('双边谱');
subplot 224; plot(freq,Theta,'k');
xlabel('频率/Hz'); ylabel('初始角/弧度'); title('相位');