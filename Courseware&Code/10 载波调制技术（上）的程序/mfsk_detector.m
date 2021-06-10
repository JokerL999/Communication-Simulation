function [Out]= mfsk_detector(M,r,COHERENCE)
% 输入参数
% M 调制阶数
% r 接受的信号点，为行矢量
% COHERENCE  MFSK的解调方案'coherent'/'noncoherent'
% 输出参数
% Out  解调输出
if strcmpi(COHERENCE,'coherent')
  phi= zeros(1,M); %对相干检测，phase为0
  ref = complex(diag(exp(1i*phi)));%生成参考星座
  Out= OptCoherentDetector(real(r),ref);%相干检测
else %非相干MFSK
  [~,Out]= max(abs(r),[],2);%相干幅度检测
  Out = Out.';
end
end