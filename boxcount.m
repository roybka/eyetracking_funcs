function stepsum=boxcount(x,y,winsize,jumps,varargin)

if ~isempty(varargin)
    sq_size=varargin{1};
    toplot=varargin{2};
else
    sq_size=.5;
    toplot=0;
end
 xlims=[0,1280];
 ylims=[0,1024];
xtics=(xlims(1):sq_size:xlims(2));
ytics=(ylims(1):sq_size:ylims(2));

   
% endinds=length(x):-jumps:1;
% startinds=endinds-winsize;
startinds=1:jumps:(length(x)-winsize+1);
endinds=startinds+winsize-1;

for k=1:length(startinds)

    cordmat=zeros(length(ytics)+1,length(xtics)+1);

for i=startinds(k):endinds(k)
    xcord=length(find(x(i)>xtics))+1;
    ycord=length(find(y(i)>ytics))+1;
    cordmat(ycord,xcord)=cordmat(ycord,xcord)+1;
    

end
stepsum(k)=sum(sum(cordmat>0));
end
if toplot
imagesc(cordmat)
figure
plot(stepsum)
end
end