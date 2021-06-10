function a_cap = bfsk_noncoherent_demod(r,Fc,Fd,L,Fs)
% BFSK的非相干解调
% 输入参数
%  r：接收信号
% Fc：载频
% Fd：距离Fc的频率偏移
%  L：比特周期的采样数目
% Fs：采样频率
% 输出参数
% a_cap - 检测得到的数据流

t = (0:1:length(r)-1)/Fs; 
F1 = (Fc+Fd/2); 
F2 = (Fc-Fd/2);

%4个解调载波信号
p1c = cos(2*pi*F1*t); 
p1s = -sin(2*pi*F1*t); 
p2c = cos(2*pi*F2*t);
p2s = -sin(2*pi*F2*t);

%积分
r1c = conv(r.*p1c,ones(1,L));
r1s = conv(r.*p1s,ones(1,L));
r2c = conv(r.*p2c,ones(1,L)); 
r2s = conv(r.*p2s,ones(1,L)); 

%下采样
r1c = r1c(L:L:end); 
r1s = r1s(L:L:end);
r2c = r2c(L:L:end);
r2s = r2s(L:L:end);

%平方相加
x = r1c.^2 + r1s.^2;
y = r2c.^2 + r2s.^2;

a_cap=(x-y)>0; %判决