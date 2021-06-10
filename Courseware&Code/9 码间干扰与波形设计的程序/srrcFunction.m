function [p,t]=srrcFunction(beta,L,Nsym)
%����ƽ���������Һ���
% �������
% alpha�� ��������
% L������������
% Nsym - �˲�����ȣ��Է���Ϊ��λ������ʱ��,-Nsym/2~Nsym/2��
% �������
%  p�����ʱ���źŲ��ε����㣬��Ӧ��ʱ�����-Nsym/2:1/L:Nsym/2

Tsym=1; t=-(Nsym/2):1/L:(Nsym/2);%unit symbol duration time-base

num = sin(pi*t*(1-beta)/Tsym)+...
    ((4*beta*t/Tsym).*cos(pi*t*(1+beta)/Tsym));
den = pi*t.*(1-(4*beta*t/Tsym).^2)/Tsym;
p = 1/sqrt(Tsym)*num./den; 

p(ceil(length(p)/2))=1/sqrt(Tsym)*((1-beta)+4*beta/pi);
temp=(beta/sqrt(2*Tsym))*( (1+2/pi)*sin(pi/(4*beta)) ...
    + (1-2/pi)*cos(pi/(4*beta)));
p(t==Tsym/(4*beta))=temp;
p(t==-Tsym/(4*beta))=temp;
end