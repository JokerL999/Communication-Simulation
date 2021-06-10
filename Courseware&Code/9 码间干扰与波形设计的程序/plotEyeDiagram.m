function [eyeVals]=plotEyeDiagram(x,L,nSamples,offset,nTraces)
% 绘制眼图函数
% 输入参数
%   x 输入信号序列
%   L 过采样因子
%   nSamples 每条扫描线的样本数，通常为L的整数倍
%   offset 从数据中offset的位置开始绘制
%   nTraces  扫描线的条数
% 输出参数
%   eyeVals 扫描线
    
M=4; %眼图的过采样因子，使得线条更光滑
tnSamp = (nSamples*M*nTraces);%总样点数目
y=interp(x,M);%过采样插值
eyeVals=reshape(y(M*offset+1:(M*offset+tnSamp)),nSamples*M,nTraces);    
t=( 0 : 1 : M*(nSamples)-1)/(M*L);
plot(t,eyeVals);
title('眼图');
xlabel('t/T_{sym}');
ylabel('幅度');
end