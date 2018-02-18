function [out unified totpar totser nb]=blinks_vec_gen_a_par_test(eyelink,delta)
if nargin==1
    delta=130
end
%bad code
%generate a vector with 1s where there's a blink (value for each time
%point)
%delta=130;

blinksbool=false(1,length(eyelink.gazeRight.time));%initialize array matching the time points
%blinksbool=boolean(blinksbool);
l=length(blinksbool);
st=GetSecs;
for p=1:3
    lasttimes(p)=eyelink.gazeRight.time((p-1)*floor(l/4)+floor(l/4));
    lastinds(p)=(p-1)*floor(l/4)+floor(l/4);
    blinksboolp{p}=false(1,floor(l/4));
end
blinksboolp{4}=false(1,l-3*floor(l/4));
lasttimes(4)=eyelink.gazeRight.time(end);
lastinds(4)=length(eyelink.gazeRight.time);
firstsampletime=eyelink.gazeRight.time(1);
a=length(eyelink.blinks.startTime); %blink number (vector length)
blstarts=eyelink.blinks.startTime;
blends=eyelink.blinks.endTime;
nb=length(blends);
blstarts_p=cell(1,4);
blstarts_p{1}=blstarts((blends<(lasttimes(1)-delta)));

blends_p=cell(1,4);
blends_p{1}=blends((blends<(lasttimes(1)-delta)));

for p=2:4
    blstarts_p{p}=blstarts((blends<=lasttimes(p))&(blstarts>lasttimes(p-1)));
    blends_p{p}=blends((blends<=lasttimes(p))&(blstarts>lasttimes(p-1)));

end
% blstarts_p{4}=blstarts_p{4}(1:end-1);
% blends_p{4}=blends_p{4}(1:end-1);
extrase=[];extras=[];allblinkss=[];allblinkse=[];
for p=1:4
      allblinkss=[ allblinkss blstarts_p{p}];
      allblinkse=[ allblinkse blends_p{p}];
   differe= length (blstarts_p{p})-length(blends_p{p});
   if differe>0
   extras=[extras blstarts_p{p}(end-(differe-1):end)];
   extrase=[extrase blends_p{p+1}(1:differe)];
   blstarts_p{p}(end-(differe-1):end)=[];
   blends_p{p+1}(1:differe)=[];
   end
 
end

extras=setdiff(blstarts,allblinkss);
extrase=setdiff(blends,allblinkse);
% for p=1:4
%    
%    extras=[extras blstarts_p{p}(end-1:end)];
%    extrase=[extrase blends_p{p}(end-1:end)];
%    blstarts_p{p}(end-1:end)=[];
%    blends_p{p}(end-1:end)=[];
%    
% end


d=GetSecs-st

parfor p=1:4
   
    if p==1
        startind=3;
        timevec{p}= eyelink.gazeRight.time(1:lastinds(p));
    else
        startind=1;
        
        timevec{p}= eyelink.gazeRight.time(lastinds(p-1)+1:lastinds(p));
    end
    for i =startind:length(blstarts_p{p})
        if (find(timevec{p}==blstarts_p{p}(i))-delta)<0     %% corrected by dekel 2/4/16 - to handle the case of too early blinks in the data
            blinksboolp{p}(2:find(timevec{p}==blstarts_p{p}(i))+delta)=1;
            disp('raresa')
        else
            blinksboolp{p}(find(timevec{p}==blstarts_p{p}(i))-delta:find(timevec{p}==blends_p{p}(i))+delta)=1;
        end
    end
end
unified=[blinksboolp{1} blinksboolp{2} blinksboolp{3} blinksboolp{4}];

if ~isempty(extras)
    disp([num2str(length(extras)) 'extras handled']);
    for i=1:length(extras)
        unified(find(eyelink.gazeRight.time==extras(i))-delta:find(eyelink.gazeRight.time==extrase(i))+delta)=1;
    end
end


totpar=-st+GetSecs;
st=GetSecs();
for i =3:(a-1)
    
    if (find(eyelink.gazeRight.time==eyelink.blinks.startTime(i))-delta)<0     %% corrected by dekel 2/4/16 - to handle the case of too early blinks in the data
     blinksbool(2:find(eyelink.gazeRight.time==eyelink.blinks.endTime(i))+delta)=1;    
    else
     blinksbool(find(eyelink.gazeRight.time==eyelink.blinks.startTime(i))-delta:find(eyelink.gazeRight.time==eyelink.blinks.endTime(i))+delta)=1;
    end
    
end
out=blinksbool';
totser=-st+GetSecs;
