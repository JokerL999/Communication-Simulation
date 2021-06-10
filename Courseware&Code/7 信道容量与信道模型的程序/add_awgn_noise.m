% AWGNģ��
function [r,n,NoisePower] = add_awgn_noise(s,SNRdB)
% AWGN����ģ��
% ���룺s �����������; SNRdB ���������; 
% �����r ����������������������; n �����ź�; NoisePower ��������

s_temp=s;
if iscolumn(s), s=s.'; end
gamma = 10^(SNRdB/10); %SNR dBֵת������ֵ  	
% �����źŹ���
if isvector(s) %��һά�����źţ���MPAM,MPSK,MQAM
    P=sum(abs(s).^2)/length(s);
else           % �Զ�ά�����źţ���MFSK, s ��MxN�ľ���
    P=sum(sum(abs(s).^2))/length(s); 
end

NoisePower=P/gamma; % ������������
%��������
if(isreal(s))
    n = sqrt(NoisePower)*randn(size(s));
else
    n = sqrt(NoisePower/2)*(randn(size(s))+1i*randn(size(s)));
end 
r = s + n; %�����źŵ�������
if iscolumn(s_temp), r=r.'; end
end