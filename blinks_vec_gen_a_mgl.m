function out=blinks_vec_gen_a_mgl(eyelink,delta)
if nargin==1
    delta=130
end
%bad code
%generate a vector with 1s where there's a blink (value for each time
%point)
%delta=130;
blinksbool=[zeros(1,length(eyelink.gaze.time))];%initialize array matching the time points
blinksbool=boolean(blinksbool);

a=length(eyelink.blinks.startTime); %blink number (vector length)
firstsampletime=eyelink.gaze.time(1);
for i =8:(a-1)
     blinksbool(find(eyelink.gaze.time==eyelink.blinks.startTime(i))-delta:find(eyelink.gaze.time==eyelink.blinks.endTime(i))+delta)=1;
     
end
out=blinksbool';