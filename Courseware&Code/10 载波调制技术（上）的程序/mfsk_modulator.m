function [s,ref]= mfsk_modulator(M,d,COHERENCE)
% 输入参数
% M 调制阶数
% d 输入符号序列，为行矢量
% COHERENCE  MFSK的解调方案'coherent'/'noncoherent'
% 输出参数
% s 调制输出
% ref 参考星座点

    if strcmpi(COHERENCE,'coherent')
        phi= zeros(1,M); %对相干检测，phase为0
        ref = complex(diag(exp(1i*phi)));
        s = complex(ref(d,:)); %符号影射到对应的星座上 
    else
        phi = 2*pi*rand(1,M);%M个在(0,2pi)上的随机相位
        ref = diag(exp(1i*phi));
        s = ref(d,:);
    end
end