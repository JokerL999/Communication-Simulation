%�������ɿռ�·�����
clearvars; close all;

Pt_dBm=52; %���书��
Gt_dBi=25; %������������
Gr_dBi=15; %������������
f=1e9; %�ź�Ƶ��
d =41935000*(1:1:200) ; %����ʸ��
L=1; %ϵͳ���
n=2; %·��ָ��
%----------------------------------------------------
[PL,Pr_dBm] = FreeSpaceModel(Pt_dBm,Gt_dBi,Gr_dBi,f,d,L,n);
plot(log10(d),Pr_dBm); title('���ɿռ�·�����ģ��');
xlabel('log10(d)'); ylabel('���չ���(dBm)');