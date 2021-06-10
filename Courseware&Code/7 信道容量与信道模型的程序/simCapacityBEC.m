% �������BEC����
clearvars; close all; clc
nBits=10^5;           %���͵ı�����
errorProbs = 0:0.1:1; %��������
C = zeros(1,length(errorProbs));
j=1;
for e=errorProbs %for each error probability
    x = randi([0,1],1,nBits);
    y = bec_channel(x,e);  %ͨ��BEC�ŵ�
    
    pye = sum(y==-1)/nBits ;%�����ĸ���
    C(j) = 1-pye; %����    
    j=j+1;
end
plot(errorProbs,C); title('�����Ʋ����ŵ�����');
xlabel('�������� - e'); 
ylabel('���� (bits/channel use)');