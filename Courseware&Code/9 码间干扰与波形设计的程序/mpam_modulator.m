function [s,ref]=mpam_modulator(M,d)
% �������
% M ���ƽ���
% d ����������У�Ϊ��ʸ��
% �������
% s �������
% ref �ο�������
m=1:1:M; 
Am=complex(2*m-1-M); %��������ͼ
s = complex(Am(d));  %����Ӱ�䵽��Ӧ�������� 
ref = Am;  
end