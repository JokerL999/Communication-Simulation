function y=bin2deci(x)
%���ܣ������������еĶ�����ת��ʮ������
l=length(x);
y=(l-1:-1:0);
y=2.^y;
y=x*y';