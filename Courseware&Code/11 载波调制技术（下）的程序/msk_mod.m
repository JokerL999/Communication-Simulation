function [s,t,I,Q] = msk_mod(a,fc,OF)
% MSK����
% �������
%  a - ���������������
%  fc- ��Ƶ[Hz]
%  OF - ���������ӣ�fc�ı���������4����
% �������
%  s - QPSK�ز������ź�
%  t - �ز������źŵ�ʱ��ʸ��
%  I - I·�źţ�������
%  Q - Q·�źţ�������
ak = 2*a-1; %NRZ���� 0-> -1, 1->+1
ai = ak(1:2:end); % �������������
aq = ak(2:2:end); % ż�����������

L=2*OF;  %���Ų����� Tsym=2xTb
%�ϲ��������л� I·��Q·
ai = [ai zeros(length(ai),L-1)]; ai=ai.';ai=ai(:);
aq = [aq zeros(length(aq),L-1)]; aq=aq.';aq=aq(:);

ai = [ai(:) ; zeros(L/2,1)].'; % ʸ���󲹰���������ڵ�0
aq = [zeros(L/2,1); aq(:)].';  % ʱ�Ӱ������

%�����ͨ�˲���
Fs=OF*fc;
Ts=1/Fs;
Tb = OF*Ts; 
t=0:Ts:2*Tb;
h = sin(pi*t/(2*Tb));%��ͨ�˲���
% ��·�ź�ͨ����ͨ�˲���
I = filter(h,1,ai);%I·�����ź�
Q = filter(h,1,aq);%Q·�����ź�

t=(0:1:length(I)-1)*Ts; 
iChannel = I.*cos(2*pi*fc*t); 
qChannel = Q.*sin(2*pi*fc*t);
s = iChannel-qChannel; %��ͨMSK�����ź�

doPlot=1; 
if doPlot==1,%���Ͷ˲���
  figure;
  subplot(3,1,1);hold on;plot(t,I,'--');plot(t,iChannel,'r');
  xlabel('t'); ylabel('s_I(t)');xlim([-Tb,20*Tb]);
  subplot(3,1,2);hold on;plot(t,Q,'--');plot(t,qChannel,'r');
  xlabel('t'); ylabel('s_Q(t)');xlim([-Tb,20*Tb]);
  subplot(3,1,3);plot(t,s,'k'); 
  xlabel('t'); ylabel('s(t)');xlim([-Tb,20*Tb]);
end
end
