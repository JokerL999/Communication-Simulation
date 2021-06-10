function [SIGNAL,fVals]=FreqDomainAnalysis(signal,Fs,type)
%�����źŵ�Ƶ��������
%signal - �ź�����
%Fs - ����Ƶ��
%type - 'single' or 'double' - ���ص���/˫��FFT
% SIGNAL��Ƶ��������
% fVals�� Ƶ�ʿ̶�
NFFT=2^nextpow2(length(signal)); %FFT length
if (nargin ==1) 
    Fs=1; 
    type='double'; 
end
if (nargin==2) 
    type='double'; 
end
if strcmpi(type,'single') % ����FFT
    SIGNAL=fft(signal,NFFT); 
    SIGNAL=2*SIGNAL(1:NFFT/2)/NFFT; %ֻȡ��Ƶ�ʲ���
    fVals=Fs*(0:NFFT/2-1)/NFFT;
else % ˫��FFT
    SIGNAL=fftshift(fft(signal,NFFT))/NFFT;
    fVals=Fs*(-NFFT/2:NFFT/2-1)/NFFT;
end,end