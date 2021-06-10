function output=MyResample(x,p,q,varargin)
%x ��������
%p,q �ٲ������ӣ���Ϊ�����������ϲ���p���ٽ�����q
%n ������˲����������� ����ΪL = 2*n*max��p,q��+1;
%beta  Kaiser������
%m �������� 0-�Լ�ʵ�ֵ�ʱ���ֵ����
%          1-�Լ�ʵ�ֵ�Ƶ���ֵ����
%          2-��Matlab resample������uniformResample����������Ĵ���

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
lx=length(x); % x�ĳ���

if m==0
    %�Լ�ʵ�ֵĲ����ʱ任����
    %����p-1����
    x1=[x;repmat(zeros(1,length(x)),p-1,1)];
    x2=reshape(x1,1,size(x1,1)*size(x1,2)); 
    
    pqmax = max(p,q);  
    fc = 1/pqmax; %�˲�����ֹƵ��
    L = 2*n*pqmax+1; %�˲�������      
    h=firls( L-1, [0 fc fc 1], [1 1 0 0]).*kaiser(L,bta)'; %�Ӵ��˲���
    %fir1(L-1,2*fc,kaiser(L,bta));
    win = p*h/sum(h); %�Ӵ���������һ�����˲���������Ϊp   
    y=conv(win,x2);
    
    %FIR�˲�������ʱ�ӣ�Ϊȡ�м�Ĳ��֣�ȥ����λһ��L-1����
    halfL=floor((L-1)/2); 
    halfR=L-1-halfL;
    y1=y;
    y1(1:halfL)=[];
    y1(end-halfR+1:end)=[];
    
    %q��������
    y2=y1(1:q:end);
    output=y2;          
elseif m==1
    %Ƶ���ֵ����2��Ƶ���м���㣬ʵ��ʱ��M����ֵ
     X=fft(x,lx); 
     X4=[X(1:floor(lx/2)) zeros(1,(p-1)*lx) X(floor(lx/2)+1:lx)];
     n4=p*lx;
     x4=ifft(X4,n4)*p;
     output=x4(1:q:end);
elseif m==2 %��Matlab resample������uniformResample����������Ĵ���
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