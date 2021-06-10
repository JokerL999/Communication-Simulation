%可靠通信的香浓功率极限
close all;clearvars;

k =0.1:0.001:15; 
EbN0=(2.^k-1)./k;
semilogy(10*log10(EbN0),k);
xlabel('E_b/N_0 (dB)');
ylabel('频谱效率 (\eta)');
title('信道容量与功率效率极限')
hold on;grid on; 
xlim([-2 20]);ylim([0.1 10]);
yL = get(gca,'YLim');
line([-1.59 -1.59],yL,'Color','r','LineStyle','--');
