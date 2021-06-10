function [Out]= mqam_detector(M,r)
% 输入参数
% M 调制阶数
% r 接受的信号点，为行矢量
% 输出参数
% Out  解调输出

if(((M~=1) && ~mod(floor(log2(M)),2))==0) %M 必须是2的偶数幂
    error('只支持方形MQAM. M必须是2的偶数幂');
end
ref=constructQAM(M); %生成星座图
Out= OptCoherentDetector(r,ref); %IQ detection
end
