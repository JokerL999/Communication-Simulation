% ����Ҷ�任ʾ��
clearvars;close all;

syms t v w x; 
x=exp(-2*t)*heaviside(t); %���Ŷ����ʱ���ź�
X=fourier(x);             % ����Ҷ�任
subplot(311); 
fplot(x);                 %ʱ���źŲ���
title(char(x))
xlabel('t')
subplot(312);
fplot(abs(X))             %������
title(char(abs(X)))
xlabel('w')
subplot(313); 
fplot(angle(X))           %��λ��
title(char(angle(X)))
xlabel('w')