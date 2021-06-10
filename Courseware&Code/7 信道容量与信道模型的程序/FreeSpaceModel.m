function [PL,Pr_dBm] = FreeSpaceModel(Pt_dBm,Gt_dBi,Gr_dBi,f,d,L,n)
% ���ɿռ�·�����ģ��
% ���������Pt_dBm ���书��[dBm];Gt_dBi ������������[dBi]
%           Gr_dBi ������������[dBi];f �ź�Ƶ��[Hz]
%            d �շ�����ʸ��[m]; L ����ϵͳ��ģ������L=1��
%           n ·�����ָ�������ɿռ�n=2��;
% ���������Pr_dBm ���չ���[dBm];PL ·�����[dB]

lambda=3e8/f; %����
K = 20*log10(lambda/(4*pi))-10*n*log10(d)-10*log10(L);
PL = Gt_dBi + Gr_dBi + K; 
Pr_dBm = Pt_dBm + PL;
end