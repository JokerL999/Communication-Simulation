close all; clearvars;
rng default;

Tsym=1; %��������
L=10; %���������ӣ�ÿ�����ŵ�������Ŀ��
Nsym = 20; %�˲�����ȣ��Է���Ϊ��λ������ʱ��,-Nsym/2~Nsym/2��
alphas=[0 0.3 0.5 1];%��������
Fs=L/Tsym;%������

for i=1:length(alphas) 
    alpha=alphas(i);
    [rcPulse(i,:),t]=raisedCosineFunction(alpha,L,Nsym); % ���ɲ���   
    [vals(i,:),f]=FreqDomainAnalysis(rcPulse(i,:),Fs,'double'); % Ƶ�����  
end

lineColors=['b','r','g','k','c']; 
legendString=cell(1,4);
t=Tsym*t; 
for i=1:length(alphas) 
    alpha=alphas(i);
    figure(1) 
    plot(t,rcPulse(i,:),lineColors(i));hold on;     
    figure(2)
    plot(f,abs(vals(i,:))/abs(vals(i,length(vals(i,:))/2+1)),lineColors(i)); 
    hold on;
    legendString{i}=strcat('\alpha =',num2str(alpha) );
end
figure(1);title('����������');legend(legendString);
figure(2);title('Ƶ����Ӧ');legend(legendString);

