function [p,t]=sincFunction(L,Tsym,Nsym)
% ����sinc����
% �������
%  L�����������ӣ�ÿ�����ŵ�������Ŀ��
%  Tsym:����ʱ��
%  Nsym���˲�����ȣ����ų���ʱ�䣩
% �������
%  p�����ʱ���źŲ��ε����㣬��Ӧ��ʱ�����-Nsym/2:1/L:Nsym/2
t=-(Nsym/2)*Tsym:Tsym/L:(Nsym/2)*Tsym;
p = sin(pi*t/Tsym)./(pi*t/Tsym);
p(ceil(length(p)/2))=1; %�� sinc(0/0)Ϊ1
end