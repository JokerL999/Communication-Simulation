%示例栅栏现象
clearvars; close all;

%% 不考虑频率分辨率的频率分析
Fs = 20; Ts = 1/Fs; f1=5; f2=4.5;
t = 0:Ts:2;   
xt = 1+sin(2*pi*f1*t) + sin(2*pi*f2*t);
[Xf, f] = SimpleSpectrumViewer(xt, Fs);

subplot(221)
plot(t, xt)
xlabel('t'); ylabel('时域幅度'); title('时域信号')
subplot(223)
plot(f, abs(Xf));xlabel('f');ylabel('幅度谱')
title('不考虑频域分辨率计算的频谱')

%% 设定频率分辨率的频率分析
Fdelta=0.1;                                    %频率分辨率
M=Fs/Fdelta;                                   %实现频率分辨率的序列长度
t=0:Ts:(M-1)*Ts;
xt =1+sin(2*pi*f1*t) + sin(2*pi*f2*t);          %信号采样
[Xf, f] = SpectrumViewer(xt,Fs,'onesided',Fdelta);         %设定频率分辨率的频域分析

subplot(222)
plot(t, xt);xlabel('t');ylabel('时域幅度');title('时域信号')
subplot(224)
plot(f, abs(Xf));xlabel('f');ylabel('幅度谱');title('基于频率分辨率计算的频谱')