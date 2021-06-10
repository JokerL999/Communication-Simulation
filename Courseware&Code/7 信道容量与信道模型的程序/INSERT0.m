function[out]=INSERTO(d,M)
%将输入的序列扩展成间隔M-1个0的序列
N=length(d);
out=zeros(1,M*N);
for i=0:N-1
    out(i*M+1)=d(i+1);
end
end