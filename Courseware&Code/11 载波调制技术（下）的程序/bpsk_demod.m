function [ak_cap] = bpsk_demod(r_bb,L)
% �������BPSK�����ź�
%r_bb - ���������ź�
%L - ����������(Tsym/Tsam)
%ak_cap - �����Ķ�����������
x=real(r_bb); %I·
x = conv(x,ones(1,L));%����L�����㣨Tsymʱ�䣩
x = x(L:L:end);  %I·��������
ak_cap = (x > 0).'; %���޼��