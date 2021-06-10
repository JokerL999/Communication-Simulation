% AWGN模型
function [r,n,NoisePower] = add_awgn_noise(s,SNRdB)
% AWGN噪声模型
% 输入：s 输入符号序列; SNRdB 符号信噪比; 
% 输出：r 叠加噪声后的输出符号序列; n 噪声信号; NoisePower 噪声功率

s_temp=s;
if iscolumn(s), s=s.'; end
gamma = 10^(SNRdB/10); %SNR dB值转成线性值  	
% 计算信号功率
if isvector(s) %对一维输入信号，如MPAM,MPSK,MQAM
    P=sum(abs(s).^2)/length(s);
else           % 对多维输入信号，如MFSK, s 是MxN的矩阵
    P=sum(sum(abs(s).^2))/length(s); 
end

NoisePower=P/gamma; % 计算噪声功率
%生成噪声
if(isreal(s))
    n = sqrt(NoisePower)*randn(size(s));
else
    n = sqrt(NoisePower/2)*(randn(size(s))+1i*randn(size(s)));
end 
r = s + n; %接收信号叠加噪声
if iscolumn(s_temp), r=r.'; end
end