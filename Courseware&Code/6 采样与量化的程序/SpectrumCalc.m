function [Yf, f] = SpectrumCalc(yt, fs, df)
%yt:ʱ���źŲ���
%fs:������
%df:��СƵ�ʷֱ���

if nargin == 2
  M=0;
else
  M=fs/df;        %����Ƶ�ʷֱ���Ҫ���趨FFT�ĵ���
end

L = length(yt);
N =2^(max(nextpow2(M),nextpow2(L))); %ʵ��FFT�ĵ���
Yf = fft(yt,N);

Yf = 2*abs(Yf(1:N/2+1))/L;
f = fs/2*linspace(0,1,N/2+1);
end