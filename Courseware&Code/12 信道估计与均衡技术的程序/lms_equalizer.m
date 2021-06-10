function w=lms_equalizer(N,mu,r,a,delay)
% LMS������
% �������
% N �� �˲�������
% mu = LMS���µĲ���
% r = �����ź�
% a = �ο��ź�
% delay�� ������ʱ��
% �������
% w����������ͷϵ��

w=zeros(N,1);%��ʼ����������ͷϵ��Ϊ0
for k=N:length(r)
    r_vector = r(k:-1:k-N+1)';
    e = a(k-delay)-w'*r_vector;
    w = w + mu*conj(e)*r_vector;
end
end