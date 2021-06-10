function r = add_awgn_noise(s,SNRdB)
% 输入参数
%   s 输入符号序列
%   SNRdB 符号信噪比
% 输出参数
%   r 叠加噪声后的输出符号序列
s_temp=s;
if iscolumn(s), s=s.'; end
gamma = 10^(SNRdB/10); %SNR dB值转成线性值  	

% 计算信号功率
if isvector(s) %对矢量输入信号，如MPAM,MPSK,MQAM
    P=sum(abs(s).^2)/length(s);
else  % 对多维输入信号，如MFSK
    P=sum(sum(abs(s).^2))/length(s); %if s is a matrix [MxN]
end

N0=P/gamma; % 计算噪声功率谱
%生成噪声
if(isreal(s))
    n = sqrt(N0)*randn(size(s));
else
    n = sqrt(N0/2)*(randn(size(s))+1i*randn(size(s)));
end 
r = s + n; %接收信号叠加噪声
if iscolumn(s_temp), r=r.'; end
end