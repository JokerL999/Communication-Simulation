% —› æ–Ú¡–µπœ‡

f1=-2:3;
k1=-2:3;
[f,k] = SeqRev(f1,k1)

figure
subplot(211)
stem(k1,f1)
axis([min(k1)-1,max(k1)+1, min(f1)-0.5,max(f1)+0.5])
subplot(212)
stem(k,f,'filled')
axis([min(k)-1,max(k)+1, min(f)-0.5,max(f)+0.5])



