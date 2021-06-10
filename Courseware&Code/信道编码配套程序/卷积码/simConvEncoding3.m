% 演示卷积码编码器
% clc

% k=1;  %每一时钟周期输入编码器的比特数
% g=[1 0 1;
%    1 1 1];  %生成矩阵
% L=size(g,2)/k; %约束长度
% 
% msg=[1 0 0 1 1 0 0 1 0 1 0 1 1] %输入信息序列

k=2;
g=[0 0 1 0 1 0 0 1;
   0 0 0 0 0 0 0 1;
   1 0 0 0 0 0 0 1];

msg=[1 0 0 1 1 1 0 0 1 1 0 0 0 0 1 1]

% trellis=poly2trellis([L],[13,17]);
% code=convenc([msg zeros(1,L-1)],trellis) %信息序列补了L-1个0，清空移位器
 rx_sig=ConvolutionEncoder(g,k,msg);
% output=[0 1 1 0 1 1 1 1 0 1 0 0 0 1];

decoder_output=ConvolutionDecoder(g,k,rx_sig)


