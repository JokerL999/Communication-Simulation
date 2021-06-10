function [Xf, f] = SpectrumViewer(xt, Fs, freqRange,df)
% Ƶ�׷����������ף�
% �������
% xt:ʱ���źŲ�������; Fs:����Ƶ��; freqRange:����/˫�߷���; df:��СƵ�ʷֱ��ʣ����㣩
% �������
% Xf:Ƶ�����; f: Ƶ��̶�

if nargin == 2
  M=0;
  freqRange='onesided';
elseif nargin == 3
  M=0;
else
  M=Fs/df;                          %���ݼ���Ƶ�׷ֱ���Ҫ���趨FFT�ĵ���  
end

L = length(xt);
N =2^(max(nextpow2(M),nextpow2(L))); %ʵ��FFT�ĵ���
X = fft(xt,N);

if strcmp(freqRange,'onesided') % ���߷���         
    Xf=zeros(1,floor(N/2-0.5)+1);         %Ƶ������洢�ռ䣬����Ϊfloor(N/2-0.5)+1
    Xf(1)=X(1)/L;                         %ֱ������,ע�⣬����ʵ�����ݳ���
    Xf(2:end) = 2*X(floor(1:N/2-0.5)+1)/L; %��ֱ��Ƶ�׷��������������ף�
    f =floor(0:N/2-0.5)*Fs/N;             %Ƶ��̶�
elseif strcmp(freqRange,'twosided') % ˫�߷���   
    Xf = fftshift(X)/L;                   %Ƶ�׷���������˫���ף�
    f =floor(-N/2+0.5:N/2-0.5)*Fs/N;      %Ƶ��̶ȣ�ע�⣬����ʵ�����ݳ���  
end
end
