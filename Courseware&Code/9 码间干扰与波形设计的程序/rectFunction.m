function [p,t]=rectFunction(L,Nsym)
% ���ɷ�������
%L - ����������
%Nsym - ���γ��ȣ���λ������
%p ������
%t ����ʱ��-(Nsym/2):1/L:(Nsym/2)

Tsym=1;t=-(Nsym/2):1/L:(Nsym/2);
p=(t > -Tsym/2) .* (t <= Tsym/2);
end