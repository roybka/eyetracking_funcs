function out=blinks_vec_gen_a(eyelink,delta)
if nargin==1
    delta=130;
end
%bad code
%generate a vector with 1s where there's a blink (value for each time
%point)
%delta=130;
blinksbool=false(1,length(eyelink.gazeRight.time));%initialize array matching the time points
%blinksbool=boolean(blinksbool);

a=length(eyelink.blinks.startTime); %blink number (vector length)
firstsampletime=eyelink.gazeRight.time(1);
for i =3:(a-1)
    
    if (find(eyelink.gazeRight.time==eyelink.blinks.startTime(i))-delta)<0     %% corrected by dekel 2/4/16 - to handle the case of too early blinks in the data
     blinksbool(2:find(eyelink.gazeRight.time==eyelink.blinks.endTime(i))+delta)=1;    
    else
     blinksbool(find(eyelink.gazeRight.time==eyelink.blinks.startTime(i))-delta:find(eyelink.gazeRight.time==eyelink.blinks.endTime(i))+delta)=1;
    end
    
end
out=blinksbool';