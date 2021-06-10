function [s,t,I,Q] = msk_mod(a,fc,OF)
% MSK调制
% 输入参数
%  a - 输入二进制数据流
%  fc- 载频[Hz]
%  OF - 过采样因子，fc的倍数，至少4以上
% 输出参数
%  s - QPSK载波调制信号
%  t - 载波调制信号的时间矢量
%  I - I路信号（基带）
%  Q - Q路信号（基带）
ak = 2*a-1; %NRZ编码 0-> -1, 1->+1
ai = ak(1:2:end); % 奇数序号数据流
aq = ak(2:2:end); % 偶数序号数据流

L=2*OF;  %符号采样率 Tsym=2xTb
%上采样和序列化 I路和Q路
ai = [ai zeros(length(ai),L-1)]; ai=ai.';ai=ai(:);
aq = [aq zeros(length(aq),L-1)]; aq=aq.';aq=aq(:);

ai = [ai(:) ; zeros(L/2,1)].'; % 矢量后补半个符号周期的0
aq = [zeros(L/2,1); aq(:)].';  % 时延半个周期

%构造低通滤波器
Fs=OF*fc;
Ts=1/Fs;
Tb = OF*Ts; 
t=0:Ts:2*Tb;
h = sin(pi*t/(2*Tb));%低通滤波器
% 两路信号通过低通滤波器
I = filter(h,1,ai);%I路基带信号
Q = filter(h,1,aq);%Q路基带信号

t=(0:1:length(I)-1)*Ts; 
iChannel = I.*cos(2*pi*fc*t); 
qChannel = Q.*sin(2*pi*fc*t);
s = iChannel-qChannel; %带通MSK调制信号

doPlot=1; 
if doPlot==1,%发送端波形
  figure;
  subplot(3,1,1);hold on;plot(t,I,'--');plot(t,iChannel,'r');
  xlabel('t'); ylabel('s_I(t)');xlim([-Tb,20*Tb]);
  subplot(3,1,2);hold on;plot(t,Q,'--');plot(t,qChannel,'r');
  xlabel('t'); ylabel('s_Q(t)');xlim([-Tb,20*Tb]);
  subplot(3,1,3);plot(t,s,'k'); 
  xlabel('t'); ylabel('s(t)');xlim([-Tb,20*Tb]);
end
end
