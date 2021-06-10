function [s,ref]=mpam_modulator(M,d)
% 输入参数
% M 调制阶数
% d 输入符号序列，为行矢量
% 输出参数
% s 调制输出
% ref 参考星座点
m=1:1:M; 
Am=complex(2*m-1-M); %生成星座图
s = complex(Am(d));  %符号影射到对应的星座上 
ref = Am;  
end