% ¿Î…¢∏µ¿Ô“∂±‰ªª æ¿˝
clearvars;close all;

x=[1 2 2 1];
N=length(x);
Xk=dft(x);

figure
subplot(211)
mag=abs(Xk);
stem(0:N-1,mag);
legend ('|X_k|')
subplot(212)
phas=angle(Xk);
stem(0:N-1,phas);
legend ('\angle Xk')



