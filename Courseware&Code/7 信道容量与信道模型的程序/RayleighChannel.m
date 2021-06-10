function H=RayleighChannel(sigma,L)
% 生成基于包络的瑞利衰落信道
% 输入：sigma 实部和虚部的标准方差参数，L 生成的数据长度
% 输出：H 瑞利分布的复随机数
 H=sigma*(randn(1,L)+1i*randn(1,L));
end