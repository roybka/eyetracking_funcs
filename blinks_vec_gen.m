function out=blinks_vec_gen_a(eyelink,delta)
if nargin==1
    delta=130
end
%bad code
%generate a vector with 1s where there's a blink (value for each time
%point)
%delta=130;
blinksbool=[zeros(1,length(eyelink.gazeRight.time))];%initialize array matching the time points


a=length(eyelink.blinks.startTime); %blink number (vector length)
firstsampletime=eyelink.gazeRight.time(1);
for i =3:a
     blinksbool(find(eyelink.gazeRight.time==eyelink.blinks.startTime(i))-delta:find(eyelink.gazeRight.time==eyelink.blinks.endTime(i))+delta)=1;
     
end
out=blinksbool';