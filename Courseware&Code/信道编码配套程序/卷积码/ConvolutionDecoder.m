function [decoder_output,survivor_state,cumulated_metric]=ConvolutionDecoder(G,k,decoder_input)
% 功能：卷积码的Viterbi译码器
% 输入：G 生成矩阵 k 每一时钟周期输入编码器的比特数 decoder_input 译码器输入
% 输出：decoder_output 译码输出。survivor_state 幸存路径 cumulated_metric 累积度量值
 
n=size(G,1); % n 编码输出端口数量,(n,k,m)中n=2
if rem(size(G,2),k) ~=0 
  error('错误，G的行数与k不匹配') %G行数应为k的倍数（每k个信息编成n个长度的码字）
end
if rem(size(decoder_input,2),n) ~=0
  error('错误，G的列数与解码序列长度不匹配') %解码序列的长度应为G列数的倍数
end

L=size(G,2)/k; %约束长度，也即寄存器的个数
M=2^k;         %输入信号的个数（每个状态引出的分支数）
number_of_states=2^((L-1)*k);% 寄存器的状态数（网格图的行数）

input=zeros(number_of_states,number_of_states); %保存每个状态所有分支的输入信号
nextstate=zeros(number_of_states,M); %保存每个状态所有分支的下一状态
output=zeros(number_of_states,M); %保存每个状态所有分支的编码输出信号

% 产生状态转移矩阵（下一状态）、输出矩阵和输入矩阵
% 注意：状态、输入和输出都是从0开始序号，但matlab数组只支持从1开始，因此下面存储序号都是+1
for j=0:number_of_states-1 %尽管状态用二进制序列表示，为仿真方便，这里用十进制表示
    for m=0:M-1   %尽管输入信号用二进制序列表示，为仿真方便，这里用十进制表示
        [next_state,memory_contents]=get_next_state(j,m,L,k);
        %注意：memory_contents包括新输入以及即将在下一状态被移除的历史内容，方便下面的卷积计算
        input(j+1,next_state+1)=m;%十进制表示的输入信号
        branch_output=rem(memory_contents*G',2); %计算卷积编码输出
        nextstate(j+1,m+1)=next_state;%十进制表示的下一状态
        output(j+1,m+1)=bin2deci(branch_output);%将卷积输出用十进制表示
    end
end

state_metric=zeros(number_of_states,2);  % 记录译码过程中每个状态的度量值（汉明距或欧式距）
%state_metric（:,1）当前状态位置的度量值，为确定值，而（:,2）为当前状态加输入得到的下一个状态度量值，为临时值
depth_of_trellis=length(decoder_input)/n; % 网格深度（也就是网格图中的列数）
decoder_input_matrix=reshape(decoder_input,n,depth_of_trellis);% 译码器输入序列改成每列n个元素的矩阵，便于后面的分支度量值的计算
survivor_state=zeros(number_of_states,depth_of_trellis); %保存幸存路径，也即路径中每个状态的前一状态

% 非尾部比特的译码
for i=1:depth_of_trellis-L+1 %对除最后L-1个输入比特进行译码
    flag=zeros(1,number_of_states); % 状态被访问的标记
    %在网格图中，随着每一次输入信息，状态数从1→2→4...→number_of_states/2→number_of_states
    %step控制上述状态数的变化 
    if i <= L  
        step=2^((L-i)*k);
    else
        step=1;
    end
    
    for j=0:step:number_of_states-1 % 进入的状态序号
        for m=0:M-1 %对每个进入的状态，试探可能的输入信息
            binary_output=deci2bin(output(j+1,m+1),n);%给出在状态j下，若输入信息m，从网格图上得到对应的编码器输出
            %计算这n比特码字与待译码的码字度量值(汉明距)
            branch_metric=sum(decoder_input_matrix(:,i)~=binary_output');
            %选择码间距离较小的那条路径
            %选择方法：当下一个状态next_state没有被访问时就直接赋值(之前没有分支，不用选择)，否则，用比它小的将其覆盖
            %注意：覆盖的原因是一个状态可能由多个状态到达，state_metric(next_state+1,2)保存的是先前获得的度量值最小值
            %      若本次尝试发现更小的度量值（state_metric(j+1,1)+branch_metric），则意味着这次试探的路径更好
            %      因此，将next_state到达分支设为j（也即是由j状态到达的），并更新度量值
            next_state=nextstate(j+1,m+1);%原先网格图记录的最优路径下的下一状态
            if((state_metric(next_state+1,2) > state_metric(j+1,1)+branch_metric) || flag(next_state+1)==0)
                state_metric(next_state+1,2) = state_metric(j+1,1)+branch_metric;
                %survivor_state(next_state+1,i+1)=j;
                survivor_state(next_state+1,i)=j;
                flag(next_state+1)=1;
            end
        end
    end
    state_metric(:,1)=state_metric(:,2);%将state_metric（:,1）更新为state_metric（:,2）
end

%  尾比特的译码.
for i=depth_of_trellis-L+2:depth_of_trellis
    flag=zeros(1,number_of_states); %状态被访问的标记
    %在网格图中，尾比特译码时候，随着每一次输入信息，状态数从number_of_states→number_of_states/2→...→2→1
    %last_stop控制上述状态数的变化 
    last_stop=number_of_states/(2^((i-depth_of_trellis+L-2)*k));
    for j=0:last_stop-1
        binary_output=deci2bin(output(j+1,1),n);
        %计算这n比特码字与待译码的码字度量值(汉明距)
        branch_metric=sum(decoder_input_matrix(:,i)~=binary_output');
        %类似于非尾比特的译码，但因为是尾比特译码，尾比特都是0，下一状态都进入固定的0分支
        next_state=nextstate(j+1,1);
        if((state_metric(next_state+1,2) > state_metric(j+1,1)+branch_metric) || flag(next_state+1)==0)
            state_metric(next_state+1,2) = state_metric(j+1,1)+branch_metric;
            %survivor_state(next_state+1,i+1)=j;
            survivor_state(next_state+1,i)=j;
            flag(next_state+1)=1;
        end
    end
    state_metric(:,1)=state_metric(:,2);%将state_metric（:,1）更新为state_metric（:,2）
end

% 根据survivor_state找出幸存路径
state_sequence=zeros(1,depth_of_trellis+1); % 保存译码路径上的每次输入对应的状态
state_sequence(1,depth_of_trellis)=survivor_state(1,depth_of_trellis);
for i=1:depth_of_trellis
    previous_state=state_sequence(1,depth_of_trellis+2-i); % 幸存路径中当前状态的前一状态
    state_sequence(1,depth_of_trellis-i+1)=survivor_state(previous_state+1,depth_of_trellis-i+1);
end

% 译码输出
decoder_output_matrix=zeros(k,depth_of_trellis-L+1);%注意：只译出非尾比特
for i=1:depth_of_trellis-L+1
    dec_output_deci=input(state_sequence(1,i)+1,state_sequence(1,i+1)+1);%根据当前状态和下一状态，得到输入信息比特
    dec_output_bin=deci2bin(dec_output_deci,k);
    decoder_output_matrix(:,i)=dec_output_bin(k:-1:1)';
end
decoder_output=reshape(decoder_output_matrix,1,k*(depth_of_trellis-L+1)); %译码结果
cumulated_metric=state_metric(1,1);
