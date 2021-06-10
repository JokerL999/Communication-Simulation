clearvars; close all; clc;

Fs = 1000;
nfft = 1024;  %fft采样点数

%产生序列
n = 0:1/Fs:1;
xn = cos(2*pi*100*n) + 3*cos(2*pi*200*n)+(randn(size(n)));
subplot(2,1,1);plot(xn);title('加噪信号');xlim([0 1000]);grid on
% 随机信号的频谱
subplot(2,1,2)
[Xf, f] = SpectrumViewer(xn, Fs, 'onesided');
Y = abs(Xf);
plot(f,Y,'linewidth',2);
grid; xlabel('频率/Hz');  ylabel('幅值')

figure
%FFT直接平方
Y2=Y.^2;
subplot(3,1,1);plot(f,10*log10(Y2));title('直接法');grid on
xlabel('频率[Hz]');ylabel('功率谱密度[dB/Hz]')

%周期图法
window = boxcar(length(xn));  %矩形窗
[psd1,f] = periodogram(xn,window,nfft,Fs);
subplot(3,1,2);plot(f,10*log10(psd1));title('周期图法');grid on
xlabel('频率[Hz]');ylabel('功率谱密度[dB/Hz]')

%自相关法
cxn = xcorr(xn,'unbiased');  %计算自相关函数
CXk = fft(cxn,nfft)/nfft;
psd2 = abs(CXk)*2;           %单边谱，*2
index = 0:round(nfft/2-1);
k = index*Fs/nfft;
psd2 = (psd2(index+1));
subplot(313)
plot(k,10*log10(psd2));title('间接法');grid on
xlabel('频率[Hz]');ylabel('功率谱密度[dB/Hz]')