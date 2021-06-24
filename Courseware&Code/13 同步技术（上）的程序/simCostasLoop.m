% 利用Costas环实现相位跟踪

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

%% 抑制载波的载波调制
fc=1000;                   % 载波频率
phoff=1.0;                 % 相位
c=cos(2*pi*fc*t+phoff);    % 构造载波信号
r=s.*c;                    % 载波调制（抑制载波）

n=500;                     % LPF的阶数  
ff=[0 .01 .02 1];          % 低通滤波器的截止频率远小于2*fc/(Fs/2)=0.4
fa=[1 1 0 0];
h=firpm(n,ff,fa);          % LPF
mu=.003;                   % 算法补偿
f0=1000;                   % 接收机的频率
theta=zeros(1,length(t));  % 估计相位矢量
theta(1)=0;                % 初始估计
zs=zeros(1,n+1); zc=zeros(1,n+1);   % 滤波器输出的缓存
for k=1:length(t)-1                   
  zs=[zs(2:n+1), 2*r(k)*sin(2*pi*f0*t(k)+theta(k))];
  zc=[zc(2:n+1), 2*r(k)*cos(2*pi*f0*t(k)+theta(k))];
  lpfs=fliplr(h)*zs'; lpfc=fliplr(h)*zc'; % 滤波器输出
  theta(k+1)=theta(k)-mu*lpfs*lpfc;   % 自适应算法更新
end

plot(t,theta),
title('基于Costas环的相位跟踪')
xlabel('时间'); ylabel('相位偏移')
