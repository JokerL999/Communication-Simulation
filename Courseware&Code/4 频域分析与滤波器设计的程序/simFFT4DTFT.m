% ��FFT������ɢʱ�丵��Ҷ�任DTFT
clearvars;close all;

nx=0:11;
x=0.9.^nx;
nx=0:11;

%% fft���
N1=length(x); 
dw1=2*pi/(N1);                     % ������г��ȼ�Ƶ�ʷֱ���
k1=floor((-(N1-1)/2):((N1-1)/2));  % ��Գ�����Ƶ�ʵ�FFTλ������
X1=fftshift(fft(x,N1));            % ��Գ�����Ƶ�ʵ�FFT����ֵ

%% ����fft�����Ƶ�ʷֱ���
N2=128; 
dw2=2*pi/(N2);                     % ������г��ȼ�Ƶ�ʷֱ���
k2=floor((-(N2-1)/2):((N2-1)/2));  % ��Գ�����Ƶ�ʵ�FFTλ������
X2=fftshift(fft(x,N2));            % ��Գ�����Ƶ�ʵ�FFT����ֵ

%% DTFT���㷨
w=-pi:0.01:pi;		               % ��������Ƶ�׵�ϸ��Ƶ�� 
X=x*exp(-1i*nx'*w);                % ��������Ƶ��

%% ���ƽ��
subplot(211)
plot(w,abs(X),k1*dw1,abs(X1),'m:',k2*dw2,abs(X2),'x-.');      % ����Ƶ����ͼ
legend('DTFT','�ǲ���FFT','����FFT')
xlabel('Ƶ��'),ylabel('����')
subplot(212)
plot(w,angle(X),k1*dw1,angle(X1),'m:',k2*dw2,angle(X2),'x-.') % ����Ƶ����ͼ
xlabel('Ƶ��'),ylabel('��λ')
legend('DTFT','�ǲ���FFT','����FFT')