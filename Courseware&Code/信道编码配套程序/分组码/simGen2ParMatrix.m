% ���ɾ������żУ�����ת����ʾ��
close all; clearvars;

G = [1 1 0 1 0 0 0; 
    0 1 1 0 1 0 0;
    1 1 1 0 0 1 0;
    1 0 1 0 0 0 1];

H = gen2parmat(G)% �� G to H 
G = gen2parmat(H)% �� H to G 
mod(G*H.',2) %�����Ƿ� GH?T=0