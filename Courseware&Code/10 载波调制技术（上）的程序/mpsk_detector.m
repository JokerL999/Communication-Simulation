function [Out]= mpsk_detector(M,r)
% �������
% M ���ƽ���
% r ���ܵ��źŵ㣬Ϊ��ʸ��
% �������
% Out  ������
ref_i= 1/sqrt(2)*cos(((1:1:M)-1)/M*2*pi); 
ref_q= 1/sqrt(2)*sin(((1:1:M)-1)/M*2*pi);
ref = ref_i+1i*ref_q; %����õĲο�������
Out= OptCoherentDetector(r,ref); %������ɼ��
end
