% —› æ–Ú¡–∆Ω“∆
close all; clearvars;

f1=-2:2;
k1=-2:2;
[f,k] = SeqShift(f1,k1,3)

figure
subplot(211)
stem(k1,f1)
axis([-3,3,-2.5,2.5]);
subplot(212)
stem(k,f,'filled')
axis([min(k)-1,max(k)+1, min(f)-0.5,max(f)+0.5])