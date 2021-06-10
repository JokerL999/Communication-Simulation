function [E,P]=SeqEngPower(x,ts)
% 有限长度序列的能量与功率 
% 输入参数
%  x ：信号序列
%  ts：信号序列采样周期
% 输出参数
%  E： 有限长度序列的能量
%  P： 有限长度序列的功率
 E=(sum(abs(x).^2))*ts;
 P=(sum(abs(x).^2))/length(x);
end


