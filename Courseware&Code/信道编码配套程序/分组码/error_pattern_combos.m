function [E,nRows,nCols] = error_pattern_combos(d,n)
% ���ܣ��Գ���Ϊn������Ϊd�����֣��������п��ܵĴ���ģʽ������λ����ϣ�
% ���룺n ���ֳ��� d ������
% �����E ����ģʽ nRows ���� nCols ����

C = nchoosek(1:n,d);%��1,2,...,n����ȡd�������������
m = size(C,1); 
E = zeros(m,n);%form an all zero matrix of error patterns
for i=1:m
    for j=1:d
        E(i,C(i,j))=1;
    end
end
[nRows,nCols]= size(E);%num of rows and columns E matrix
end