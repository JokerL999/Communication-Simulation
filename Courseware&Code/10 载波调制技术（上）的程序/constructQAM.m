function [ref]= constructQAM(M)
% ����
%   M   MQAM�Ľ���
%   ref Gray�����MQAM������

a=GrayCodeGen(M);     %����һάGray�����˳��
N=sqrt(M);            % K-Map��ά�� - N x N matrix
a=reshape(a,N,N).';   % ��һλGray����ĳ�N x N ����
evenRows=2:2:size(a,1); % �ҳ�ż����
a(evenRows,:)=fliplr(a(evenRows,:));%  ż����Ԫ�����ҷ�ת
nGray=reshape(a.',1,M); % �ٽ�N x N ����ת��һάʸ��

% ����MQAM��������
x=floor(nGray/N);
y=mod(nGray,N);
Ax=2*(x+1)-1-N; %PAM ���� 2m-1-D - ʵ��
Ay=2*(y+1)-1-N; %PAM ���� 2m-1-D - ����
ref=Ax+1i*Ay;   %MQAM ������ (I+jQ)
end

