function Out= mpam_detector(M,r)
% 输入参数
% M 调制阶数
% r 接受的信号点，为行矢量
% 输出参数
% Out  解调输出
m=1:1:M; 
Am=complex(2*m-1-M); %所有星座点
ref = Am;            %解调用的参考星座点
Out= OptCoherentDetector(r,ref); %最优相干检测
end
