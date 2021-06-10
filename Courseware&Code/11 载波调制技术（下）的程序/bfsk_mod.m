function [s,t,phase,at] = bfsk_mod(a,Fc,Fd,L,Fs,fsk_type)
% 使用BFSK调制二进制数据流
% 输入参数
%  a：输入二进制数据流
% Fc：载频
% Fd：距离Fc的频率偏移
%  L：比特周期的采样数目
% Fs：采样频率
% fsk_type:'COHERENT' (默认) or 'NONCOHERENT' FSK 
% 输出参数
%s - BFSK调制信号
%t - 调制信号的时间点矢量
%phase - 调制器初始相位, 适用于相干检测.
% at 输入数据的数据波形

phase=0;
at = kron(a,ones(1,L)); %数据转成波形
t = (0:1:length(at)-1)/Fs; %时间点矢量
if strcmpi(fsk_type,'NONCOHERENT')
  c1 = cos(2*pi*(Fc+Fd/2)*t+2*pi*rand);%带随机相位的载波1
  c2 = cos(2*pi*(Fc-Fd/2)*t+2*pi*rand);%带随机相位的载波2
  %注意：非相干，无相位信息返回
else
  phase=2*pi*rand;%随机相位 [0,2pi)
  c1 = cos(2*pi*(Fc+Fd/2)*t+phase);%带随机相位的载波1
  c2 = cos(2*pi*(Fc-Fd/2)*t+phase);%带随机相位的载波2 
end
s = at.*c1 +(-at+1).*c2; %BFSK信号

