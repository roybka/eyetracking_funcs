function [stepsum, xd, yd]=boxcount2(x,y,winsize,jumps,varargin)

if ~isempty(varargin)
    sq_size=varargin{1};
    toplot=varargin{2};
    screen_x=varargin{3};
    screen_y=varargin{4};
else
    sq_size=.5;
    toplot=0;
    screen_x=1280;
    screen_y=1024;

end
xlims=[0,screen_x];
ylims=[0,screen_y];
xtics=(xlims(1):sq_size:xlims(2));
ytics=(ylims(1):sq_size:ylims(2));


% endinds=length(x):-jumps:1;
% startinds=endinds-winsize;
startinds=1:jumps:(length(x)-winsize+1);
endinds=startinds+winsize-1;
xd=zeros(1,length(startinds));
yd=zeros(1,length(startinds));
stepsum=zeros(1,length(startinds));
for k=1:length(startinds)
    
    cordmat=zeros(length(ytics)+1,length(xtics)+1);
    
    for i=startinds(k):endinds(k)
        xcord=length(find(x(i)>xtics))+1;
        ycord=length(find(y(i)>ytics))+1;
        cordmat(ycord,xcord)=cordmat(ycord,xcord)+1;
        
        
    end
    d=sum(cordmat>0);
    xd(k)=sum(d>0);
    d=sum(cordmat'>0);
    yd(k)=sum(d>0);
    stepsum(k)=sum(sum(cordmat>0));
end
if toplot
    imagesc(cordmat(850:950,950:1050))
    keyboard
%     figure
%     plot(stepsum)
%     keyboard
end

end