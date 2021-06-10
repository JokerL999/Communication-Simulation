function [s,t,I,Q] = oqpsk_mod(a,fc,OF)
% OQPSK����
% �������
%  a - ���������������
%  fc- ��Ƶ[Hz]
%  OF - ���������ӣ�fc�ı���������4����
% �������
%  s - QPSK�ز������ź�
%  t - �ز������źŵ�ʱ��ʸ��
%  I - I·�źţ�������
%  Q - Q·�źţ�������
L = 2*OF; %ÿ���ŵ�������Ŀ��QPSK��ÿ������2bit��
ak = 2*a-1; %�ǹ������ 0-> -1, 1->+1
I = ak(1:2:end);% �������������
Q = ak(2:2:end);% ż�����������
I=repmat(I,1,L).'; %���������������1/2Tb������
Q=repmat(Q,1,L).'; %ż���������������1/2Tb������
I = [I(:) ; zeros(L/2,1)].'; %I·�󲹰���������ڵ�0
Q = [zeros(L/2,1); Q(:)].';  %Q·�ӳٰ����������

fs = OF*fc; %��������
t=0:1/fs:(length(I)-1)/fs; %ʱ���
iChannel = I.*cos(2*pi*fc*t);
qChannel = -Q.*sin(2*pi*fc*t);
s = iChannel + qChannel; %OQPSK�����ź�

doPlot=1; %doPlotΪ1�ͻ�ͼ
if doPlot==1,%�����Ͷ˲���
figure;subplot(3,2,1);plot(t,I);%I·��������
xlabel('t'); ylabel('I(t)-�����ź�');xlim([0,10*L/fs]);
subplot(3,2,2);plot(t,Q);%Q·��������
xlabel('t'); ylabel('Q(t)-�����ź�');xlim([0,10*L/fs]);
subplot(3,2,3);plot(t,iChannel,'r');%I·�����źŲ���
xlabel('t'); ylabel('I(t)-�ز������ź�');xlim([0,10*L/fs]);
subplot(3,2,4);plot(t,qChannel,'r');%Q·�����źŲ���
xlabel('t'); ylabel('Q(t)-�ز������ź�');xlim([0,10*L/fs]);
subplot(3,1,3);plot(t,s); %QPSK����
xlabel('t'); ylabel('s(t)');xlim([0,10*L/fs]);
end