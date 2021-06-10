function [s,t,phase,at] = bfsk_mod(a,Fc,Fd,L,Fs,fsk_type)
% ʹ��BFSK���ƶ�����������
% �������
%  a�����������������
% Fc����Ƶ
% Fd������Fc��Ƶ��ƫ��
%  L���������ڵĲ�����Ŀ
% Fs������Ƶ��
% fsk_type:'COHERENT' (Ĭ��) or 'NONCOHERENT' FSK 
% �������
%s - BFSK�����ź�
%t - �����źŵ�ʱ���ʸ��
%phase - ��������ʼ��λ, ��������ɼ��.
% at �������ݵ����ݲ���

phase=0;
at = kron(a,ones(1,L)); %����ת�ɲ���
t = (0:1:length(at)-1)/Fs; %ʱ���ʸ��
if strcmpi(fsk_type,'NONCOHERENT')
  c1 = cos(2*pi*(Fc+Fd/2)*t+2*pi*rand);%�������λ���ز�1
  c2 = cos(2*pi*(Fc-Fd/2)*t+2*pi*rand);%�������λ���ز�2
  %ע�⣺����ɣ�����λ��Ϣ����
else
  phase=2*pi*rand;%�����λ [0,2pi)
  c1 = cos(2*pi*(Fc+Fd/2)*t+phase);%�������λ���ز�1
  c2 = cos(2*pi*(Fc-Fd/2)*t+phase);%�������λ���ز�2 
end
s = at.*c1 +(-at+1).*c2; %BFSK�ź�

