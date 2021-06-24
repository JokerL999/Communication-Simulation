% 抑制载波情况下的AM调制通过平方器和带通滤波器
clearvars; close all;
rng default;

Nsym=1000;                 %符号数
L=20;                      %过采样因子
M=4;                       %MPAM的调制阶数
Ts=.0001;                  %采样周期
Fs=1/Ts;                   %采样频率

%% 基带信号波形
time=Ts*Nsym*L;            %仿真时间长度
t=Ts:Ts:time;              %仿真时间矢量
d = ceil(M.*rand(1,Nsym)); %生成随机符号
m = mpam_modulator(M,d);   %MPAM调制
mup=zeros(1,Nsym*L); 
mup(1:L:Nsym*L)=m;         % 过采样,每个样点之间为L-1个0
ps=hamming(L);             % 宽度为L的脉冲波形（以hamming窗为例）
s=filter(ps,1,mup);        % 数据与脉冲波形卷积

subplot 311
stem(t(1:10*L),mup(1:10*L))
xlabel('t');ylabel('幅度');title('基带信号')
subplot 312
plot(t(1:10*L),s(1:10*L))
xlabel('t');ylabel('幅度');title('时域波形')
%% 抑制载波的载波调制
fc=1000;                   % 载波频率
phoff=1.0;                 % 相位
c=cos(2*pi*fc*t+phoff);    % 构造载波信号
r=s.*c;                    % 载波调制（抑制载波）
%% 接收信号处理
q=r.^2;                    % 平方器
n=100;                     % 滤波器阶数
ff=[0 .38 .39 .41 .42 1];  % 带通滤波器的中心频率为2*fc/(Fs/2)=0.4
fa=[0 0 1 1 0 0];          
h=firpm(n,ff,fa);          % 使用firpm设计的带通滤波器
rp=filter(h,1,q);          % 通过带通滤波器
%% 使用FFT分析信号频率和相位
[Xf, f] = SpectrumViewer(rp, Fs, 'onesided');
subplot 313
plot(f, abs(Xf))
xlabel('f[Hz]');ylabel('幅度谱');title('频谱')

[m,imax]=max(abs(Xf))              % 寻找频谱的最大值
freqS=f(imax)                      % 最大值处的频率
phasep=angle(Xf(imax));            % 最大值处的相位
[IR,f]=freqz(h,1,length(rp),Fs);   % 滤波器的频率响应
[mi,im]=min(abs(f-freqS));         % 找出频率最大值对应的滤波器频率位置
phaseBPF=angle(IR(im));            % 峰值频率处的滤波器相位
phaseS=mod(phasep-phaseBPF,pi)     % 估计出的相位