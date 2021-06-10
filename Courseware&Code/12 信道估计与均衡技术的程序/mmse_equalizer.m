function [h_eq,MSE,optDelay]=mmse_equalizer(h_c,snr,N,delay)
% ʱ���Ż���MMSE������
% �������
% h_c���ŵ��弤��Ӧ
% snr�������dBֵ
% N �� �˲�������
% delay�� ������ʱ��
% �������
% h_eq����������ͷϵ��
% MSE���������
% optDelay�����ŵľ�����ʱ��

 h_c=h_c(:);
 L=length(h_c);  %�ŵ��弤��Ӧ����  
 H=convMatrix(h_c,N); %(L+N-1)x(N-1) ����
  
 gamma = 10^(-snr/10); % ��������/�źŹ���
 [~,optDelay] = max(diag(H*inv(conj(H')*H+gamma*eye(N))*conj(H'))); 
 optDelay=optDelay-1; %Matlabʸ����Ŵ�1��ʼ�����Ҫ��1
 n0=optDelay;
 
 if nargin==4,
   if delay >=(L+N-1), error('Too large delay'); end
   n0=delay;
 end    
 d=zeros(N+L-1,1);
 d(n0+1)=1; %ʱ���Ż���ʱ��λ��Ϊ1   
 h_eq=inv(conj(H')*H+gamma*eye(N))*conj(H')*d;%��С���ˣ�Least Squares����
 MSE=(1-d'*H*inv(conj(H')*H+gamma*eye(N))*conj(H')*d);
end