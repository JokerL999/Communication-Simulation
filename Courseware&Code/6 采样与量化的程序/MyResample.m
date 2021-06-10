function output=MyResample(x,p,q,varargin)
%x 输入序列
%p,q 再采样因子，均为正整数，先上采样p，再降采样q
%n 抗混叠滤波器阶数参数 阶数为L = 2*n*max（p,q）+1;
%beta  Kaiser窗参数
%m 方法参数 0-自己实现的时域插值方法
%          1-自己实现的频域插值方法
%          2-从Matlab resample函数中uniformResample里整理出来的代码

if nargin <4
  n=10;
  bta=5; 
  m=0;
else
    if nargin==4
        n=varargin{1};
        bta=5; 
        m=0;
    end    
    if nargin==5
        n=varargin{1};
        bta=varargin{2};   
        m=0;
    end
    if nargin==6
        n=varargin{1};
        bta=varargin{2};        
        m=varargin{3};
    end
end


[p,q] = rat( p/q, 1e-12 );
lx=length(x); % x的长度

if m==0
    %自己实现的采样率变换功能
    %插入p-1个零
    x1=[x;repmat(zeros(1,length(x)),p-1,1)];
    x2=reshape(x1,1,size(x1,1)*size(x1,2)); 
    
    pqmax = max(p,q);  
    fc = 1/pqmax; %滤波器截止频率
    L = 2*n*pqmax+1; %滤波器阶数      
    h=firls( L-1, [0 fc fc 1], [1 1 0 0]).*kaiser(L,bta)'; %加窗滤波器
    %fir1(L-1,2*fc,kaiser(L,bta));
    win = p*h/sum(h); %加窗后，能量归一化，滤波器的增益为p   
    y=conv(win,x2);
    
    %FIR滤波，会有时延，为取中间的部分，去掉首位一共L-1个点
    halfL=floor((L-1)/2); 
    halfR=L-1-halfL;
    y1=y;
    y1(1:halfL)=[];
    y1(end-halfR+1:end)=[];
    
    %q倍降采样
    y2=y1(1:q:end);
    output=y2;          
elseif m==1
    %频域插值方法2：频域中间插零，实现时域M倍插值
     X=fft(x,lx); 
     X4=[X(1:floor(lx/2)) zeros(1,(p-1)*lx) X(floor(lx/2)+1:lx)];
     n4=p*lx;
     x4=ifft(X4,n4)*p;
     output=x4(1:q:end);
elseif m==2 %从Matlab resample函数中uniformResample里整理出来的代码
     pqmax = max(p,q);
     
     fc = 1/2/pqmax;
     L = 2*n*pqmax + 1;
     h1 = firls( L-1, [0 2*fc 2*fc 1], [1 1 0 0]).*kaiser(L,bta)' ;
     h = p*h1/sum(h1);
     
     Lhalf = (L-1)/2;
     Lx = length(x);
     
     % Need to delay output so that downsampling by q hits center tap of filter.
     nz = floor(q-mod(Lhalf,q));
     z = zeros(1,nz);
     h = [z h(:).'];  % ensure that h is a row vector.
     Lhalf = Lhalf + nz;
     
     % Number of samples removed from beginning of output sequence 
     % to compensate for delay of linear phase filter:
     delay = floor(ceil(Lhalf)/q);
     
     % Need to zero-pad so output length is exactly ceil(Lx*p/q).
     nz1 = 0;
     while ceil( ((Lx-1)*p+length(h)+nz1 )/q ) - delay < ceil(Lx*p/q)
         nz1 = nz1+1;
     end
     h = [h zeros(1,nz1)];
     
     % ----  HERE'S THE CALL TO UPFIRDN  ----------------------------
     y = upfirdn(x,h,p,q);
     
     % Get rid of trailing and leading data so input and output signals line up
     % temporally:
     Ly = ceil(Lx*p/q);  % output length
     
     y(1:delay) = [];
     y(Ly+1:end) = [];     
                         
    output=y;
end