
M=4;    %����
N=1e5;  %������
a=randi([0,M-1],N,1); %���������������
Q=[1 1]; % q0=1,q1=1, PR Class 1 Scheme (Duobinary coding)

x=zeros(size(a)); %Ԥ��������Ĵ洢�ռ�
D=zeros(length(Q),1); %��������Ԥ�����������ʷԤ���뻬���洢�ռ�

for k=1:length(a)
  x(k)=mod(a(k)-(D(2:end).*Q(2:end)),M);
  D(2)=x(k);
  if length(D)>2
   D(3:end)=D(2:end-1); %�洢��������λ
  end
end
disp(x); %��ʾԤ������
bn=filter(Q,1,x)%��ر���õ������źţ����������������
acap=mod(bn,M) %ģM����
errors=sum(acap~=a) %������Ŀ