function [x,n] = SeqFold(x1,n)
% ʵ�����з��� x[n] = x1[-n]
% �������
%  x1 ��������ʱ��ʸ��n�ϵ�����
% �������
%  x��������ʱ��ʸ��n�ϵķ��ۺ������

x = fliplr(x1); 
n = -fliplr(n);
end

