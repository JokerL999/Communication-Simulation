function output=ConvolutionEncoder(G,k,msg)
% 功能：卷积码编码函数
% 输入：G 生成矩阵 k 每一时钟周期输入编码器的比特数
%      msg 输入信息序列
% 输出：code 卷积编码输出

% 判断输入信息序列是否需要补零，若需要则补零
% 信息序列的长度应为k的整数倍
if rem(length(msg),k) > 0
    msg=[msg,zeros(size(1:k-rem(length(msg),k)))];
end

% 把输入信息比特按k分组，m为所得的分组数目
m=length(msg)/k;

%  检查生成矩阵G的行数是否为k的整数倍
if rem(size(G,2),k) > 0
  error('错误，G的行数与k不匹配')
end

L=size(G,2)/k;  %约束长度，也就是当前输出，与前（L-1）个时钟的输入有关

% 在信息前后补零，使得移位寄存器清零，补零的个数维（L-1）*k个
u=[zeros(size(1:(L-1)*k)),msg,zeros(size(1:(L-1)*k))];

% 将补零后的输入序列按照每组kL个比特进行分组，每个分组起始比特位置相差k
% 第一组：1到Lk；第2组：1+k到Lk+k；第三组：1+2k到Lk+2k，依此类推
% 每个分组按照倒序排列，存在uu的列中，模拟的每个时钟周期，移位寄存器中存储的数据
uu=zeros(L*k,m+L-1);
for i=1:m+L-1
    uu(:,i)=u((i+L-1)*k:-1:(i-1)*k+1); 
end

out=rem(G*uu,2); %out的每一列是每个时刻输出的编码
output=out(:)'; %转换成行矢量输出

  
