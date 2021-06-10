function r = add_awgn_noise(s,SNRdB)
% �������
%   s �����������
%   SNRdB ���������
% �������
%   r ����������������������
s_temp=s;
if iscolumn(s), s=s.'; end
gamma = 10^(SNRdB/10); %SNR dBֵת������ֵ  	

% �����źŹ���
if isvector(s) %��ʸ�������źţ���MPAM,MPSK,MQAM
    P=sum(abs(s).^2)/length(s);
else  % �Զ�ά�����źţ���MFSK
    P=sum(sum(abs(s).^2))/length(s); %if s is a matrix [MxN]
end

N0=P/gamma; % ��������������
%��������
if(isreal(s))
    n = sqrt(N0)*randn(size(s));
else
    n = sqrt(N0/2)*(randn(size(s))+1i*randn(size(s)));
end 
r = s + n; %�����źŵ�������
if iscolumn(s_temp), r=r.'; end
end