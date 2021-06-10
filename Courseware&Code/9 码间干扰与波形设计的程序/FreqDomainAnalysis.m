function [SIGNAL,fVals]=FreqDomainAnalysis(signal,Fs,type)
%返回信号的频域分析结果
%signal - 信号样点
%Fs - 采样频率
%type - 'single' or 'double' - 返回单边/双边FFT
% SIGNAL：频域分析结果
% fVals： 频率刻度
NFFT=2^nextpow2(length(signal)); %FFT length
if (nargin ==1) 
    Fs=1; 
    type='double'; 
end
if (nargin==2) 
    type='double'; 
end
if strcmpi(type,'single') % 单边FFT
    SIGNAL=fft(signal,NFFT); 
    SIGNAL=2*SIGNAL(1:NFFT/2)/NFFT; %只取正频率部分
    fVals=Fs*(0:NFFT/2-1)/NFFT;
else % 双边FFT
    SIGNAL=fftshift(fft(signal,NFFT))/NFFT;
    fVals=Fs*(-NFFT/2:NFFT/2-1)/NFFT;
end,end