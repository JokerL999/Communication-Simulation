function [p,t]=raisedCosineFunction(alpha,L,Nsym)
%���������Һ���
% �������
% alpha�� ��������
% L������������
% Nsym - �˲�����ȣ��Է���Ϊ��λ������ʱ��,-Nsym/2~Nsym/2��
% �������
%  p�����ʱ���źŲ��ε����㣬��Ӧ��ʱ�����-Nsym/2:1/L:Nsym/2

Tsym=1; 
t=-(Nsym/2):1/L:(Nsym/2);
p = sin(pi*t/Tsym)./(pi*t/Tsym).*cos(pi*alpha*t/Tsym)./(1-(2*alpha*t/Tsym).^2);
p(ceil(length(p)/2))=1;%p(0)=1 
end