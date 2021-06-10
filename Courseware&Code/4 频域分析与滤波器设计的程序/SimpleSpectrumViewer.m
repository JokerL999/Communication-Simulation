function [Xf, f] = SimpleSpectrumViewer(xt, Fs)
%������Ƶ��ֱ��ʼ����Ƶ�ף������ף�
% �������
% xt:ʱ���źŲ�������; Fs:����Ƶ��
% �������
% Xf:Ƶ�����; % f: Ƶ��̶�

N =length(xt);                        %���г���
X= fft(xt,N);                         %fft����

Xf=zeros(1,floor(N/2-0.5)+1);         %Ƶ������洢�ռ䣬����Ϊfloor(N/2-0.5)+1
Xf(1)=X(1)/N;                         %ֱ������
Xf(2:end) = 2*X(floor(1:N/2-0.5)+1)/N; %��ֱ������Ƶ�׵����������ף�
f =floor(0:N/2-0.5)*Fs/N;             %Ƶ��̶�
end