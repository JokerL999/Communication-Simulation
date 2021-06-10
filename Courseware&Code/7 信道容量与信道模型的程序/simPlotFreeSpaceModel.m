%绘制自由空间路径损耗
clearvars; close all;

Pt_dBm=52; %发射功率
Gt_dBi=25; %发射天线增益
Gr_dBi=15; %接收天线增益
f=1e9; %信号频率
d =41935000*(1:1:200) ; %距离矢量
L=1; %系统损耗
n=2; %路径指数
%----------------------------------------------------
[PL,Pr_dBm] = FreeSpaceModel(Pt_dBm,Gt_dBi,Gr_dBi,f,d,L,n);
plot(log10(d),Pr_dBm); title('自由空间路径损耗模型');
xlabel('log10(d)'); ylabel('接收功率(dBm)');