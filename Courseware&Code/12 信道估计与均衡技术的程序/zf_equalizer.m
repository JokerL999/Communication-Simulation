function [h_eq,err,optDelay]=zf_equalizer(h_c,N,delay)
% 时延优化的迫零均衡器
% 输入参数
% h_c：信道冲激响应
% N ： 滤波器阶数
% delay： 均衡器时延
% 输出参数
% h_eq：均衡器抽头系数
% err：均衡器误差
% optDelay：最优的均衡器时延


  h_c=h_c(:); 
  L=length(h_c); %信道冲激响应长度
  H=convMatrix(h_c,N); %(L+N-1)x(N-1) 矩阵
  
  %基于MSE计算最优时延
  [~,optDelay] = max(diag(H*inv(conj(H')*H)*conj(H'))); 
  optDelay=optDelay-1;%Matlab矢量序号从1开始，因此要减1
  n0=optDelay;
  
  if nargin==3,
    if delay >=(L+N-1), error('时延太大'); end
    n0=delay;
  end
  d=zeros(N+L-1,1);
  d(n0+1)=1; %时延优化后，时延位置为1    
  h_eq=inv(conj(H')*H)*conj(H')*d;%最小二乘（Least Squares）解
  err=1-H(n0+1,:)*h_eq; 
  MSE=(1-d'*H*inv(conj(H')*H)*conj(H')*d);%MSE和误差是一样的
end