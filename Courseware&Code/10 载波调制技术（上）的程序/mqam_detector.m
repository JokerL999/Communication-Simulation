function [Out]= mqam_detector(M,r)
% �������
% M ���ƽ���
% r ���ܵ��źŵ㣬Ϊ��ʸ��
% �������
% Out  ������

if(((M~=1) && ~mod(floor(log2(M)),2))==0) %M ������2��ż����
    error('ֻ֧�ַ���MQAM. M������2��ż����');
end
ref=constructQAM(M); %��������ͼ
Out= OptCoherentDetector(r,ref); %IQ detection
end
