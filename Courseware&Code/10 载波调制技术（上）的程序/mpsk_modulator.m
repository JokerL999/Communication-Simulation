function [s,ref]=mpsk_modulator(M,d)
% �������
% M ���ƽ���
% d ����������У�Ϊ��ʸ��
% �������
% s �������
% ref �ο�������

ref_i= 1/sqrt(2)*cos(((1:1:M)-1)/M*2*pi); 
ref_q= 1/sqrt(2)*sin(((1:1:M)-1)/M*2*pi);
ref = ref_i+1i*ref_q; %��������ͼ
s = ref(d); %����Ӱ�䵽��Ӧ�������� 
end

