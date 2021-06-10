clearvars; close all; clc;

Fs = 1000;
nfft = 1024;  %fft��������

%��������
n = 0:1/Fs:1;
xn = cos(2*pi*100*n) + 3*cos(2*pi*200*n)+(randn(size(n)));
subplot(2,1,1);plot(xn);title('�����ź�');xlim([0 1000]);grid on
% ����źŵ�Ƶ��
subplot(2,1,2)
[Xf, f] = SpectrumViewer(xn, Fs, 'onesided');
Y = abs(Xf);
plot(f,Y,'linewidth',2);
grid; xlabel('Ƶ��/Hz');  ylabel('��ֵ')

figure
%FFTֱ��ƽ��
Y2=Y.^2;
subplot(3,1,1);plot(f,10*log10(Y2));title('ֱ�ӷ�');grid on
xlabel('Ƶ��[Hz]');ylabel('�������ܶ�[dB/Hz]')

%����ͼ��
window = boxcar(length(xn));  %���δ�
[psd1,f] = periodogram(xn,window,nfft,Fs);
subplot(3,1,2);plot(f,10*log10(psd1));title('����ͼ��');grid on
xlabel('Ƶ��[Hz]');ylabel('�������ܶ�[dB/Hz]')

%����ط�
cxn = xcorr(xn,'unbiased');  %��������غ���
CXk = fft(cxn,nfft)/nfft;
psd2 = abs(CXk)*2;           %�����ף�*2
index = 0:round(nfft/2-1);
k = index*Fs/nfft;
psd2 = (psd2(index+1));
subplot(313)
plot(k,10*log10(psd2));title('��ӷ�');grid on
xlabel('Ƶ��[Hz]');ylabel('�������ܶ�[dB/Hz]')