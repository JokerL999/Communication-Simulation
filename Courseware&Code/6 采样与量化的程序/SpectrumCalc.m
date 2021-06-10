function [Yf, f] = SpectrumCalc(yt, fs, df)
%yt:时序信号采样
%fs:采样率
%df:最小频率分辨率

if nargin == 2
  M=0;
else
  M=fs/df;        %根据频率分辨率要求，设定FFT的点数
end

L = length(yt);
N =2^(max(nextpow2(M),nextpow2(L))); %实际FFT的点数
Yf = fft(yt,N);

Yf = 2*abs(Yf(1:N/2+1))/L;
f = fs/2*linspace(0,1,N/2+1);
end