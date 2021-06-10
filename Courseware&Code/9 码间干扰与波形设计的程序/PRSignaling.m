function [b,t]=PRSignaling(Q,L,Nsym)
%���ɲ�����Ӧϵͳ�ĳ弤��Ӧ
%�������
%  Q - Q�˲�����ͷֵ 
%  L - ����������
%  Nsym - �˲������
% �������
%  b(t) �弤��Ӧ

% ���˲���һ���弤�źţ��õ���Ӧ�ź�
qn =  filter(Q,1,[ 0 0 0 0 0 1 0 0 0 0 0 0]);
q=[qn ;zeros(L-1,length(qn))];%�ϲ�����ÿ����ֵ֮���L-1����
q=q(:).';
Tsym=1; %����ʱ��
t=-(Nsym/2):1/L:(Nsym/2);
g = sin(pi*t/Tsym)./(pi*t/Tsym); g(isnan(g)==1)=1; %sinc����
b = conv(g,q,'same');%��� q(t) and g(t)
end