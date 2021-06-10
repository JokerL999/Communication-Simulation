function [s_bb,t] = bpsk_mod(ak,L)
% ʹ��BPSK���ƶ�����������
% �������
%  ak - ���������������
%  L  - ����������(Tsym/Tsam)
% �������
%  s_bb - BPSK�����ź�
%  t -    �����źŵ�ʱ��ʸ��

N = length(ak); %������
a = 2*ak-1; %BPSK����
ai=repmat(a,1,L).'; %������
ai = ai(:).';%���л�
t=0:N*L-1; %ʱ��ʸ��
s_bb = ai;%������������ź�