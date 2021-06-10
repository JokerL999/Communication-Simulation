function [Xf, f] = SpectrumViewer(xt, Fs, freqRange,df)
% 频谱分析（单边谱）
% 输入参数
% xt:时序信号采样序列; Fs:采样频率; freqRange:单边/双边分析; df:最小频率分辨率（计算）
% 输出参数
% Xf:频域分量; f: 频域刻度

if nargin == 2
  M=0;
  freqRange='onesided';
elseif nargin == 3
  M=0;
else
  M=Fs/df;                          %根据计算频谱分辨率要求，设定FFT的点数  
end

L = length(xt);
N =2^(max(nextpow2(M),nextpow2(L))); %实际FFT的点数
X = fft(xt,N);

if strcmp(freqRange,'onesided') % 单边分析         
    Xf=zeros(1,floor(N/2-0.5)+1);         %频域分量存储空间，长度为floor(N/2-0.5)+1
    Xf(1)=X(1)/L;                         %直流分量,注意，除以实际数据长度
    Xf(2:end) = 2*X(floor(1:N/2-0.5)+1)/L; %非直流频谱分量调整（单边谱）
    f =floor(0:N/2-0.5)*Fs/N;             %频域刻度
elseif strcmp(freqRange,'twosided') % 双边分析   
    Xf = fftshift(X)/L;                   %频谱分量调整（双边谱）
    f =floor(-N/2+0.5:N/2-0.5)*Fs/N;      %频域刻度，注意，除以实际数据长度  
end
end
