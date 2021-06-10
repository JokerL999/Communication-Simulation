% ��ɢʱ�丵��Ҷ�任ʾ��
clearvars;close all;

N=5;     %Ƶ�ʿ�ȣ�-N*pi~N*pi
%���ż���
syms w
n= 0:20;
x=0.8.^n;
X=sum(x.*exp(-1i*w*n));
subplot(211)
fplot(abs(X),[-N*pi N*pi]);
ylabel('abs(X(\omega))')
title('���ż���DTFT')
ylim([0 5.8])
subplot(212)
fplot(phase(X),[-N*pi N*pi]);
xlim([-N*pi N*pi])
ylabel('angle(X(\omega))')

%��ֵ����
K=64;        %2pi�����ڵĲ�������
dw=2*pi/K;
k=floor((-N*K/2+0.5):(N*K/2-0.5));
X=x*exp(-1i*dw*n'.*k);
w=k*dw;
figure
subplot(211)
plot(w,abs(X));
xlim([-N*pi N*pi])
ylabel('abs(X(\omega))')
title('��ֵ����DTFT')
ylim([0 5.8])
subplot(212)
plot(w,phase(X));
xlim([-N*pi N*pi])
ylabel('angle(X(\omega))')