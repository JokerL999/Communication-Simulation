function [s,ref]=mqam_modulator(M,d)
% �������
% M ���ƽ���
% d ����������У�Ϊ��ʸ��
% �������
% s �������
% ref �ο�������

if(((M~=1) && ~mod(floor(log2(M)),2))==0), %M ������2��ż����
    error('ֻ֧�ַ���MQAM. M������2��ż����');
end
  ref=constructQAM(M); %��������ͼ
  s=ref(d); %����Ӱ�䵽��Ӧ�������� 
end