function out=blinks_vec_gen_b(eyelink,delta1,delta2)
if nargin==1
    delta1=150
    delta2=150
end
%bad code
%generate a vector with 1s where there's a blink (value for each time
%point)
%delta=130;
blinksbool=[zeros(1,length(eyelink.gazeRight.time))];%initialize array matching the time points
blinksbool=boolean(blinksbool);

a=length(eyelink.blinks.startTime); %blink number (vector length)
firstsampletime=eyelink.gazeRight.time(1);
for i =8:(a-1)
     blinksbool(find(eyelink.gazeRight.time==eyelink.blinks.startTime(i))-delta1:find(eyelink.gazeRight.time==eyelink.blinks.endTime(i))+delta2)=1;
     
end
out=blinksbool';