function H=RayleighChannel(sigma,L)
% ���ɻ��ڰ��������˥���ŵ�
% ���룺sigma ʵ�����鲿�ı�׼���������L ���ɵ����ݳ���
% �����H �����ֲ��ĸ������
 H=sigma*(randn(1,L)+1i*randn(1,L));
end