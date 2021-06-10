% 离散时间傅里叶变换示例
clearvars;close all;

N=5;     %频率跨度，-N*pi~N*pi
%符号计算
syms w
n= 0:20;
x=0.8.^n;
X=sum(x.*exp(-1i*w*n));
subplot(211)
fplot(abs(X),[-N*pi N*pi]);
ylabel('abs(X(\omega))')
title('符号计算DTFT')
ylim([0 5.8])
subplot(212)
fplot(phase(X),[-N*pi N*pi]);
xlim([-N*pi N*pi])
ylabel('angle(X(\omega))')

%数值计算
K=64;        %2pi区间内的采样点数
dw=2*pi/K;
k=floor((-N*K/2+0.5):(N*K/2-0.5));
X=x*exp(-1i*dw*n'.*k);
w=k*dw;
figure
subplot(211)
plot(w,abs(X));
xlim([-N*pi N*pi])
ylabel('abs(X(\omega))')
title('数值计算DTFT')
ylim([0 5.8])
subplot(212)
plot(w,phase(X));
xlim([-N*pi N*pi])
ylabel('angle(X(\omega))')