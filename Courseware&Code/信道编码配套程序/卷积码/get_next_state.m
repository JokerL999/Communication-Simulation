function [next_state,memory_contents]=get_next_state(current_state,input,L,k)
% 功能：由寄存器当前状态和输入，确定寄存器的下一个状态和存储的内容
% 输入：current_state 当前状态 input 输入 L是约束长度 k是每一时钟周期输入编码器的比特数
% 输出：next_state 下一个状态 memory_contents 寄存器内容

binary_state=deci2bin(current_state,k*(L-1)); %将十进制表示的状态转回二进制，方便下面的寄存器内容更新
binary_input=deci2bin(input,k); %将十进制表示的输入信号转回二进制，方便下面的寄存器内容更新
next_state_binary=[binary_input,binary_state(1:(L-2)*k)];%在下一状态中，新输入保存进寄存器，同时最早的数据被移除
next_state=bin2deci(next_state_binary); %由寄存器内容表示的下一状态，转回十进制表示寄存器状态
memory_contents=[binary_input,binary_state]; %所有数据，包括新输入以及即将被移除的，便于卷积计算