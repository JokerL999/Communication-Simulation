function [Xf, f] = SimpleSpectrumViewer(xt, Fs)
%不考虑频域分辨率计算的频谱（单边谱）
% 输入参数
% xt:时序信号采样序列; Fs:采样频率
% 输出参数
% Xf:频域分量; % f: 频域刻度

N =length(xt);                        %序列长度
X= fft(xt,N);                         %fft计算

Xf=zeros(1,floor(N/2-0.5)+1);         %频域分量存储空间，长度为floor(N/2-0.5)+1
Xf(1)=X(1)/N;                         %直流分量
Xf(2:end) = 2*X(floor(1:N/2-0.5)+1)/N; %非直流分量频谱调整（单边谱）
f =floor(0:N/2-0.5)*Fs/N;             %频域刻度
end