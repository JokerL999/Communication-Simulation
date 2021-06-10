function [st,t]=SignalRecoveryFromSpectrum(sf,f)
% ��Ƶ�׼�����ɢʱ������
% ���룺sf Ƶ�ף�f Ƶ�ʵ�ʸ��
% �����st ʱ���źţ�t ʱ���ʸ��
 
df = f(2)-f(1);          %Ƶ�ʷֱ���
Fs=length(sf)*df;         %������
dt = 1/Fs;               %��������
N = length(sf);          %���ݳ���
T = dt*N;                %���ݵ�ʱ�䳤�� 
t = 0:dt:T-dt;            %ʱ���ε�ʱ���ʸ��
sff = fftshift(sf);
st = ifft(sff);           %Ƶ��תʱ��
end