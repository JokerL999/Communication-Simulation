% ��ʾ����������
% clc

% k=1;  %ÿһʱ����������������ı�����
% g=[1 0 1;
%    1 1 1];  %���ɾ���
% L=size(g,2)/k; %Լ������
% 
% msg=[1 0 0 1 1 0 0 1 0 1 0 1 1] %������Ϣ����

k=2;
g=[0 0 1 0 1 0 0 1;
   0 0 0 0 0 0 0 1;
   1 0 0 0 0 0 0 1];

msg=[1 0 0 1 1 1 0 0 1 1 0 0 0 0 1 1]

% trellis=poly2trellis([L],[13,17]);
% code=convenc([msg zeros(1,L-1)],trellis) %��Ϣ���в���L-1��0�������λ��
 rx_sig=ConvolutionEncoder(g,k,msg);
% output=[0 1 1 0 1 1 1 1 0 1 0 0 0 1];

decoder_output=ConvolutionDecoder(g,k,rx_sig)


