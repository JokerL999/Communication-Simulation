% Ƶ��ѡ�����ŵ�ģ�͵�FIR����
PDP = [0 -5 -10 -15 -20]; %PDPʸ��[dB]
L=1e6; %�ŵ�ʵ�ָ���

N = length(PDP);    %�ŵ���ͷ��
PDP = 10.^(PDP/10); 
a = sqrt(PDP);      %·������ת�ɳ�ͷϵ������������֣�

R=1/sqrt(2)*(randn(L,N) + 1i*randn(L,N));%Rayleigh�����
taps= repmat(a,L,1).*R; %��ͷϵ��= a[n]*R[n]
normTaps = 1/sqrt(sum(PDP))*taps; %��һ����FIR��ͷ

display('ÿ����ͷ��ƽ������'); 
average_power = 20*log10(mean(abs(normTaps),1))
display('·��������'); 
h_abs = sum(mean(abs(normTaps).^2,1))