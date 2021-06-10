function [a,xx]=FouierSeries(x,T,N)
% ����Ҷ�����ֽ����ۺ�ʵ��
% �������
% x - ���ű�ʾ�������ź�
% T - ����
% N - ����Ҷ����ϵ���ķ�Χ��-N~N
% �������
% a - ����Ҷ����ϵ��
% xx- �����ۺ��ź�

  syms t
  t0=0;
  w=2*pi/T;
  a=zeros(1,2*N+1);
  for k=-N:N
    a(k+N+1)=(1/T)*int(x*exp(-1i*k*w*t),t,t0,t0+T); % ���㸵��Ҷ����
  end
  for k=-N:N
    ex(k+N+1)=exp(1i*k*w*t);
  end
  xx=sum(a.*ex);
end