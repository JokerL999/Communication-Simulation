function Out= mpam_detector(M,r)
% �������
% M ���ƽ���
% r ���ܵ��źŵ㣬Ϊ��ʸ��
% �������
% Out  ������
m=1:1:M; 
Am=complex(2*m-1-M); %����������
ref = Am;            %����õĲο�������
Out= OptCoherentDetector(r,ref); %������ɼ��
end
