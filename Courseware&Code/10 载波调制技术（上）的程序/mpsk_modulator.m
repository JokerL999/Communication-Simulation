function [s,ref]=mpsk_modulator(M,d)
% 输入参数
% M 调制阶数
% d 输入符号序列，为行矢量
% 输出参数
% s 调制输出
% ref 参考星座点

ref_i= 1/sqrt(2)*cos(((1:1:M)-1)/M*2*pi); 
ref_q= 1/sqrt(2)*sin(((1:1:M)-1)/M*2*pi);
ref = ref_i+1i*ref_q; %生成星座图
s = ref(d); %符号影射到对应的星座上 
end

