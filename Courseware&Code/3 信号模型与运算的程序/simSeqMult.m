% —› æ–Ú¡–œ‡≥À
close all; clearvars;

x1=-2:2;
n1=-2:2;
x2=[1 1 1];
n2=-1:1;
[x,k] = SeqMult(x1,n1,x2,n2);
figure

subplot(311)
stem(n1,x1),axis([-3,3,-2.5,2.5]);
subplot(312)
stem(n2,x2),axis([-3,3,-2.5,2.5]);
subplot(313)
stem(k,x,'filled')
axis([(min(min(n1),min(n2))-1),(max(max(n1),max(n2))+1),(min(x)-0.5),(max(x)+0.5)])

