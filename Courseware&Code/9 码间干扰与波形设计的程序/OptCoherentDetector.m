function idealPoints= OptCoherentDetector(received,ref)
%最优相干检测，适用于MPAM,MPSK,MQAM和MFSK
%received - 接收到的复信号
%ref - 参考星座点
%idealPoints 解调输出符号

[m,~] = size(received);
[n,~] = size(ref);

if m==1 %输入序列为一位矢量，如MPAM,MPSK,MAQM,把信号构造成二维上的星座坐标
    x=[real(received); imag(received)]';%接收信号的实部与虚部
    y=[real(ref); imag(ref)]';          %参考星座点
else %对于正交信号，如MFSK，本身已是一个多维信号
    x=received;
    y=ref;
end


X = sum(x.*x,2);
Y = sum(y.*y,2)';
d = X(:,ones(1,n)) + Y(ones(1,m),:) - 2*x*y';%欧氏距的平方.
[~,idealPoints]=min(d,[],2); %寻找最小欧式距的符号
idealPoints=idealPoints.';
end

