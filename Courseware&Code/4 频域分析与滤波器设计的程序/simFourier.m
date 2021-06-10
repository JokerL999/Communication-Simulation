% 傅里叶变换示例
clearvars;close all;

syms t v w x; 
x=exp(-2*t)*heaviside(t); %符号定义的时域信号
X=fourier(x);             % 傅里叶变换
subplot(311); 
fplot(x);                 %时域信号波形
title(char(x))
xlabel('t')
subplot(312);
fplot(abs(X))             %幅度谱
title(char(abs(X)))
xlabel('w')
subplot(313); 
fplot(angle(X))           %相位谱
title(char(angle(X)))
xlabel('w')