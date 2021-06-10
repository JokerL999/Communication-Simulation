% 演示信号能量和功率计算
close all;clearvars;

Fsam=100;
Tsam=1/Fsam;
t=0:Tsam:10-Tsam;
x=cos(2*pi*10*t);

[E,P]=SeqEngPower(x,Tsam)

