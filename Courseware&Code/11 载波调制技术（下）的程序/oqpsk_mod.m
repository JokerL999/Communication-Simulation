function [s,t,I,Q] = oqpsk_mod(a,fc,OF)
% OQPSK调制
% 输入参数
%  a - 输入二进制数据流
%  fc- 载频[Hz]
%  OF - 过采样因子，fc的倍数，至少4以上
% 输出参数
%  s - QPSK载波调制信号
%  t - 载波调制信号的时间矢量
%  I - I路信号（基带）
%  Q - Q路信号（基带）
L = 2*OF; %每符号的样点数目（QPSK的每个符号2bit）
ak = 2*a-1; %非归零编码 0-> -1, 1->+1
I = ak(1:2:end);% 奇数序号数据流
Q = ak(2:2:end);% 偶数序号数据流
I=repmat(I,1,L).'; %奇数序号数据流以1/2Tb波特率
Q=repmat(Q,1,L).'; %偶数数序号数据流以1/2Tb波特率
I = [I(:) ; zeros(L/2,1)].'; %I路后补半个符号周期的0
Q = [zeros(L/2,1); Q(:)].';  %Q路延迟半个符号周期

fs = OF*fc; %采样函数
t=0:1/fs:(length(I)-1)/fs; %时间点
iChannel = I.*cos(2*pi*fc*t);
qChannel = -Q.*sin(2*pi*fc*t);
s = iChannel + qChannel; %OQPSK调制信号

doPlot=1; %doPlot为1就画图
if doPlot==1,%画发送端波形
figure;subplot(3,2,1);plot(t,I);%I路基带波形
xlabel('t'); ylabel('I(t)-基带信号');xlim([0,10*L/fs]);
subplot(3,2,2);plot(t,Q);%Q路基带波形
xlabel('t'); ylabel('Q(t)-基带信号');xlim([0,10*L/fs]);
subplot(3,2,3);plot(t,iChannel,'r');%I路调制信号波形
xlabel('t'); ylabel('I(t)-载波调制信号');xlim([0,10*L/fs]);
subplot(3,2,4);plot(t,qChannel,'r');%Q路调制信号波形
xlabel('t'); ylabel('Q(t)-载波调制信号');xlim([0,10*L/fs]);
subplot(3,1,3);plot(t,s); %QPSK波形
xlabel('t'); ylabel('s(t)');xlim([0,10*L/fs]);
end