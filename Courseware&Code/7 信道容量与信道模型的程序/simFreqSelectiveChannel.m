% 频率选择性信道模型的FIR生成
PDP = [0 -5 -10 -15 -20]; %PDP矢量[dB]
L=1e6; %信道实现个数

N = length(PDP);    %信道抽头数
PDP = 10.^(PDP/10); 
a = sqrt(PDP);      %路径增益转成抽头系数（非随机部分）

R=1/sqrt(2)*(randn(L,N) + 1i*randn(L,N));%Rayleigh随机数
taps= repmat(a,L,1).*R; %抽头系数= a[n]*R[n]
normTaps = 1/sqrt(sum(PDP))*taps; %归一化的FIR抽头

display('每个抽头的平均功率'); 
average_power = 20*log10(mean(abs(normTaps),1))
display('路径总增益'); 
h_abs = sum(mean(abs(normTaps).^2,1))