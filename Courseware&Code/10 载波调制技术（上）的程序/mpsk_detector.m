function [Out]= mpsk_detector(M,r)
% 输入参数
% M 调制阶数
% r 接受的信号点，为行矢量
% 输出参数
% Out  解调输出
ref_i= 1/sqrt(2)*cos(((1:1:M)-1)/M*2*pi); 
ref_q= 1/sqrt(2)*sin(((1:1:M)-1)/M*2*pi);
ref = ref_i+1i*ref_q; %解调用的参考星座点
Out= OptCoherentDetector(r,ref); %最优相干检测
end
