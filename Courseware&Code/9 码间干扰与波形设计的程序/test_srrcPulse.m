close all; clearvars;
rng default;

Tsym=1; %��������
L=10; %���������ӣ�ÿ�����ŵ�������Ŀ��
Nsym = 20; %�˲�����ȣ��Է���Ϊ��λ������ʱ��,-Nsym/2~Nsym/2��
betas=[0 0.3 0.5 1];%��������
Fs=L/Tsym;%������

for i=1:length(betas) 
    beta=betas(i);
    [srrcPulseAtTx(i,:),t]=srrcFunction(beta,L,Nsym); %SRRC�����˲���
    srrcPulseAtRx(i,:) = srrcPulseAtTx(i,:);%SRRC�ն��˲������ͷ���һ��
    %�����˲����ϲ�
    combinedResponse(i,:) = conv(srrcPulseAtTx(i,:),srrcPulseAtRx(i,:),'same');    
   
    [vals(i,:),F]=FreqDomainAnalysis(srrcPulseAtTx(i,:),Fs,'double');
end

lineColors=['b','r','g','k','c']; 
legendString=cell(1,length(betas) );
t=Tsym*t;
for i=1:length(betas)     
    beta=betas(i);
    figure(1)
    plot(t,combinedResponse(i,:)/max(combinedResponse(i,:)),lineColors(i));
    hold on; 
    
    figure(2)
    plot(F,abs(vals(i,:))/abs(vals(i,length(vals(i,:))/2+1)),lineColors(i)); 
    hold on;
    legendString{i}=strcat('\beta =',num2str(beta) );i=i+1;  
end

figure(1)
title('SRRC�˲����ĺϲ���Ӧ'); legend(legendString);
figure(2)
title('SRRC�˲��������˻��նˣ�Ƶ����Ӧ');legend(legendString);