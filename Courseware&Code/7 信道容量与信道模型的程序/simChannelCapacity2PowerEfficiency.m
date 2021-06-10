%�ɿ�ͨ�ŵ���Ũ���ʼ���
close all;clearvars;

k =0.1:0.001:15; 
EbN0=(2.^k-1)./k;
semilogy(10*log10(EbN0),k);
xlabel('E_b/N_0 (dB)');
ylabel('Ƶ��Ч�� (\eta)');
title('�ŵ������빦��Ч�ʼ���')
hold on;grid on; 
xlim([-2 20]);ylim([0.1 10]);
yL = get(gca,'YLim');
line([-1.59 -1.59],yL,'Color','r','LineStyle','--');
