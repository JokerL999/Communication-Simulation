function [r,n] = add_awgn_noise(s,SNRdB,samplesPerSymbol)
% �������
%   s �����������
%   SNRdB ���������
%   samplesPerSymbol ��������
% �������
%   r ����������������������
%   n ���ӵ�����

    L=length(s); 
    s_temp=s;
	if iscolumn(s), s=s.'; end;
    SNR = 10^(SNRdB/10); %SNR to linear scale    
	if nargin==2, samplesPerSymbol=1; end %if third argument is not given, set it to 1
    Esym=samplesPerSymbol*sum(abs(s).^2)/(L); %Calculate actual symbol energy
    N0=Esym/SNR; %Find the noise spectral density
    
    if(isreal(s))
        noiseSigma = sqrt(N0/2);%Standard deviation for AWGN Noise when x is real
        n = noiseSigma*randn(1,L);%computed noise
    else
        noiseSigma=sqrt(N0/2);%Standard deviation for AWGN Noise when x is complex
        n = noiseSigma*(randn(1,L)+1i*randn(1,L));%computed noise
    end  
    
    r = s + n; %received signal
	if iscolumn(s_temp), r=r.'; end;	%return r in original format as that of s
end