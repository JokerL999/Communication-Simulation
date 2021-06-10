function [st,t]=SignalRecoveryFromSpectrum(sf,f)
% 由频谱计算离散时间序列
% 输入：sf 频谱；f 频率点矢量
% 输出：st 时域信号；t 时间点矢量
 
df = f(2)-f(1);          %频率分辨率
Fs=length(sf)*df;         %采样率
dt = 1/Fs;               %采样周期
N = length(sf);          %数据长度
T = dt*N;                %数据的时间长度 
t = 0:dt:T-dt;            %时域波形的时间点矢量
sff = fftshift(sf);
st = ifft(sff);           %频域转时域
end