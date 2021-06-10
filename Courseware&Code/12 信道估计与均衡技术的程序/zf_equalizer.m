function [h_eq,err,optDelay]=zf_equalizer(h_c,N,delay)
% ʱ���Ż������������
% �������
% h_c���ŵ��弤��Ӧ
% N �� �˲�������
% delay�� ������ʱ��
% �������
% h_eq����������ͷϵ��
% err�����������
% optDelay�����ŵľ�����ʱ��


  h_c=h_c(:); 
  L=length(h_c); %�ŵ��弤��Ӧ����
  H=convMatrix(h_c,N); %(L+N-1)x(N-1) ����
  
  %����MSE��������ʱ��
  [~,optDelay] = max(diag(H*inv(conj(H')*H)*conj(H'))); 
  optDelay=optDelay-1;%Matlabʸ����Ŵ�1��ʼ�����Ҫ��1
  n0=optDelay;
  
  if nargin==3,
    if delay >=(L+N-1), error('ʱ��̫��'); end
    n0=delay;
  end
  d=zeros(N+L-1,1);
  d(n0+1)=1; %ʱ���Ż���ʱ��λ��Ϊ1    
  h_eq=inv(conj(H')*H)*conj(H')*d;%��С���ˣ�Least Squares����
  err=1-H(n0+1,:)*h_eq; 
  MSE=(1-d'*H*inv(conj(H')*H)*conj(H')*d);%MSE�������һ����
end