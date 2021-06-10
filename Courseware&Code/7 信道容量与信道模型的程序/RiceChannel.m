function H=RiceChannel(K,L)
% 生成基于包络的莱斯衰落信道
% 输入：sigma 实部和虚部的标准方差参数，K 莱斯K因子，L 生成的数据长度
% 输出：H 莱斯分布的复随机数
 g1 = sqrt(K/(2*(K+1))); 
 g2 =  sqrt(1/(2*(K+1)));
 H=(g2*randn(1,L)+g1)+1i*(g2*randn(1,L)+g1); 
end