function w=lms_equalizer(N,mu,r,a,delay)
% LMS均衡器
% 输入参数
% N ： 滤波器阶数
% mu = LMS更新的步长
% r = 接收信号
% a = 参考信号
% delay： 均衡器时延
% 输出参数
% w：均衡器抽头系数

w=zeros(N,1);%初始化均衡器抽头系数为0
for k=N:length(r)
    r_vector = r(k:-1:k-N+1)';
    e = a(k-delay)-w'*r_vector;
    w = w + mu*conj(e)*r_vector;
end
end