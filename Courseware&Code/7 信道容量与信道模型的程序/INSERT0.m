function[out]=INSERTO(d,M)
%�������������չ�ɼ��M-1��0������
N=length(d);
out=zeros(1,M*N);
for i=0:N-1
    out(i*M+1)=d(i+1);
end
end