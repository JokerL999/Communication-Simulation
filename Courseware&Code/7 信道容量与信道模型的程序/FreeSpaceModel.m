function [PL,Pr_dBm] = FreeSpaceModel(Pt_dBm,Gt_dBi,Gr_dBi,f,d,L,n)
% 自由空间路径损耗模型
% 输入参数：Pt_dBm 发射功率[dBm];Gt_dBi 发射天线增益[dBi]
%           Gr_dBi 接收天线增益[dBi];f 信号频率[Hz]
%            d 收发距离矢量[m]; L 其他系统损耗（无损耗L=1）
%           n 路径损耗指数（自由空间n=2）;
% 输出参数：Pr_dBm 接收功率[dBm];PL 路径损耗[dB]

lambda=3e8/f; %波长
K = 20*log10(lambda/(4*pi))-10*n*log10(d)-10*log10(L);
PL = Gt_dBi + Gr_dBi + K; 
Pr_dBm = Pt_dBm + PL;
end