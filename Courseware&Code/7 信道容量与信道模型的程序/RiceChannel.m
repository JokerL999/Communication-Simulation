function H=RiceChannel(K,L)
% ���ɻ��ڰ������˹˥���ŵ�
% ���룺sigma ʵ�����鲿�ı�׼���������K ��˹K���ӣ�L ���ɵ����ݳ���
% �����H ��˹�ֲ��ĸ������
 g1 = sqrt(K/(2*(K+1))); 
 g2 =  sqrt(1/(2*(K+1)));
 H=(g2*randn(1,L)+g1)+1i*(g2*randn(1,L)+g1); 
end