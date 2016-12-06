function HFD=HiguchiFD(x,kmax)
%Input:
%x: (either column or row) vector of length N
%kmax: k is the time interval, kmax is the maximum value of k       

%Output:
%HFD: Higuchi fractal dimension of x

if ~exist('kmax','var')||isempty(kmax),             %if kmax is not exist or if kmax is exist but do not have a number, then kmax = 5.
    kmax=5;
end;                                                %basically, in normal situation, it won't happen.

x=x(:)';
N=length(x);

Lmk=zeros(kmax,kmax);                              
for k=1:kmax,                                       %k is the interval time, m is the start point                              
    for m=1:k,
        Lmki=0;                     %the L value for a certain k and m, Calculation starts here-----------------%               
        for i=1:fix((N-m)/k),                       %i is the steping index, need to be multiply by k
            Lmki=Lmki+abs(x(m+i*k)-x(m+(i-1)*k));
        end;
        Ng=(N-1)/(fix((N-m)/k)*k);
        Lmk(m,k)=(Lmki*Ng)/k;       %---------------------------Calculation stops here--------------------------%     
    end;
end;
% What is a Lmk? When you choose a time interval k and a start point m, Lmk
% represent the FLUCTUATION you measured using this sample time series.
                                    
% NOTE:the index (m,k) for Lmk: (assuming kmax is 3)
%      k=1  k=2  k=3
% m=1  L11  L12  L13    |
% m=2   0   L22  L23    | <== Lmk
% m=3   0    0   L33    |

Lk=zeros(1,kmax);                   % averaging the non-zero elements for each column                         
for k=1:kmax,
    Lk(1,k)=sum(Lmk(1:k,k))/k;
end;                                % so the Lk is a function of k (k = 1,...,kmax)
% Lk means when you choose a sampled data with a time interval k, the
% FLUCTUATION of the time series you can measure.

lnLk=log(Lk);
lnk=log(1./[1:kmax]);
% Higuchi said:"if Lk is proportional to k^(-D),then the curve is fractal
% with the dimension D. So let's assume Lk = Wk^(-D),where W is a constant.
% then we assume k^(-1)is K, then Lk  = WK^D. logLk = logW + DlogK, so
% logLk = Dlog(1/k)+logW.
% So, if we assume logLk and log(1/k) can form a linar function, then the
% slope is the fractal dimension we want.
b=polyfit(lnk,lnLk,1);
HFD=b(1);

