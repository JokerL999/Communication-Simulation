% 两径信道演示
clearvars; close all;
rng default;

p=[0.99, 0.9];
N=1e4;
d=5;

for i=1:length(p)
    A=[1 -2*p(i) p(i)^2];
    B=(1-p(i))^2;
    white_noise_seq1=randn(1,N);
    white_noise_seq2=randn(1,N);
    
    R1(i,:)=filter(B,A,white_noise_seq1);
    R2(i,:)=filter(B,A,white_noise_seq2);
    
    h(i,:)=R1(i,d+1:N)+R2(i,1:N-d);    
end

subplot 211
plot(1:N,R1(1,:),'-',1:N,R2(1,:),'--',1:N-d,h(1,:),':');

subplot 212
plot(1:N,R1(2,:),'-',1:N,R2(2,:),'--',1:N-d,h(2,:),':');

figure
Ts=1;
subplot 211
H=fft(h(1,:),N);
plot([-N/2+1:N/2]/N/Ts/10^6,10*log10(H.*conj(H)),'k-');
xlabel('Frequency[MHz]'), ylabel('Channel power[dB]')
title('Frequency response, \sigma_\tau=25ns, T_S=50ns');

subplot 212
H=fft(h(2,:),N);
plot([-N/2+1:N/2]/N/Ts/10^6,10*log10(H.*conj(H)),'k-');
xlabel('Frequency[MHz]'), ylabel('Channel power[dB]')
title('Frequency response, \sigma_\tau=25ns, T_S=50ns');