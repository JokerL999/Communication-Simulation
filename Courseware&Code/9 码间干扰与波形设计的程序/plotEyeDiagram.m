function [eyeVals]=plotEyeDiagram(x,L,nSamples,offset,nTraces)
% ������ͼ����
% �������
%   x �����ź�����
%   L ����������
%   nSamples ÿ��ɨ���ߵ���������ͨ��ΪL��������
%   offset ��������offset��λ�ÿ�ʼ����
%   nTraces  ɨ���ߵ�����
% �������
%   eyeVals ɨ����
    
M=4; %��ͼ�Ĺ��������ӣ�ʹ���������⻬
tnSamp = (nSamples*M*nTraces);%��������Ŀ
y=interp(x,M);%��������ֵ
eyeVals=reshape(y(M*offset+1:(M*offset+tnSamp)),nSamples*M,nTraces);    
t=( 0 : 1 : M*(nSamples)-1)/(M*L);
plot(t,eyeVals);
title('��ͼ');
xlabel('t/T_{sym}');
ylabel('����');
end