% 用FFT计算离散时间傅立叶变换DTFT
clearvars;close all;

nx=0:11;
x=0.9.^nx;
nx=0:11;

%% fft求解
N1=length(x); 
dw1=2*pi/(N1);                     % 求出序列长度及频率分辨率
k1=floor((-(N1-1)/2):((N1-1)/2));  % 求对称于零频率的FFT位置向量
X1=fftshift(fft(x,N1));            % 求对称于零频率的FFT序列值

%% 补零fft，提高频率分辨率
N2=128; 
dw2=2*pi/(N2);                     % 求出序列长度及频率分辨率
k2=floor((-(N2-1)/2):((N2-1)/2));  % 求对称于零频率的FFT位置向量
X2=fftshift(fft(x,N2));            % 求对称于零频率的FFT序列值

%% DTFT计算法
w=-pi:0.01:pi;		               % 生成连续频谱的细分频率 
X=x*exp(-1i*nx'*w);                % 计算连续频谱

%% 绘制结果
subplot(211)
plot(w,abs(X),k1*dw1,abs(X1),'m:',k2*dw2,abs(X2),'x-.');      % 画幅频特性图
legend('DTFT','非补零FFT','补零FFT')
xlabel('频率'),ylabel('幅度')
subplot(212)
plot(w,angle(X),k1*dw1,angle(X1),'m:',k2*dw2,angle(X2),'x-.') % 画相频特性图
xlabel('频率'),ylabel('相位')
legend('DTFT','非补零FFT','补零FFT')