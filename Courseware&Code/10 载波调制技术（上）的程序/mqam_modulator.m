function [s,ref]=mqam_modulator(M,d)
% 输入参数
% M 调制阶数
% d 输入符号序列，为行矢量
% 输出参数
% s 调制输出
% ref 参考星座点

if(((M~=1) && ~mod(floor(log2(M)),2))==0), %M 必须是2的偶数幂
    error('只支持方形MQAM. M必须是2的偶数幂');
end
  ref=constructQAM(M); %生成星座图
  s=ref(d); %符号影射到对应的星座上 
end