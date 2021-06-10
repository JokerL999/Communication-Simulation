function a_cap = bfsk_coherent_demod(r,Fc,Fd,L,Fs,phase)
% BFSK的相干解调
% 输入参数
%  r：接收信号
% Fc：载频
% Fd：距离Fc的频率偏移
%  L：比特周期的采样数目
% Fs：采样频率
% phase：调制器初始相位
% 输出参数
% a_cap - 检测得到的数据流

t = (0:1:length(r)-1)/Fs; %时间矢量
x = r.*(cos(2*pi*(Fc+Fd/2)*t+phase)-cos(2*pi*(Fc-Fd/2)*t+phase));
y = conv(x,ones(1,L)); %积分
a_cap = y(L:L:end)>0;%采样并检测
end