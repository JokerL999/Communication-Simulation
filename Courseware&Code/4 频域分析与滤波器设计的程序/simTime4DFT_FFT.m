% DFT��FFT����ʱ��Ƚ�
clearvars;close all;

N=2^12;
n=0:N-1;
x=(-1).^n;
 
disp('DFT')
tic
X=dft(x);
toc
 
disp('FFT')
tic
X=fft(x);
toc
