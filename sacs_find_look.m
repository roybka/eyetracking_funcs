% This is a general function useful for extracting (micro)saccades from any
% experiment, look at the raw data conveniently, and plot the main
% sequence. 

%when used, change the filename parameter to your filename, amplitudelim to make it also work for large saccades, 
% and most importantly, your events in terms of sample number in the
% eyelink array.

%you must have all the microsaccade detection functions in the specified
%path below (or change the path mentioned). 

%Roy Amit 27/8/2014



addpath('C:\Users\Owner\Documents\m-files\analysis\microsaccade_detection')
addpath('C:\Users\Owner\Documents\m-files\analysis')
addpath('C:\Users\Owner\Documents\m-files')
filename='sm_s2_1';
load(filename);
s=who;
s=s{2};
s=eval(s);
%________________________________________
%#########IMPORTANT PARAMETERS############:
eyeball=0; %to view trial by trial =1, else =0
mainseq=1; %draw a correlation graph between amplitude and peak eye velocity (measure of saccade detection reliability)
filtrar=1; %filter the data or not
bandpass=60; %lowpass filter bp 
amplitudelim=60; %microsaccade= 90 // saccades=2000
%____________________________________
%######### trial info and time locking:
trials=0; %if its an experiment with trials =1...
trial_start_code=210; %what code locks the trial timing
baseline=0;%time to analize before that code  
seglen=10000; %length of trial (not below 1000).
%#######################

DPP=0.159;%0.0241

blinks=blinks_vec_gen_a(s); % <==== function call here


if filtrar
s.gazeRight.x=naninterp(s.gazeRight.x);
s.gazeRight.y=naninterp(s.gazeRight.y);
s.gazeRight.x=lowPassFilter(bandpass,s.gazeRight.x,1000);
s.gazeRight.y=lowPassFilter(bandpass,s.gazeRight.y,1000);
s.gazeLeft.x=naninterp(s.gazeLeft.x);
s.gazeLeft.y=naninterp(s.gazeLeft.y);
s.gazeLeft.x=lowPassFilter(bandpass,s.gazeLeft.x,1000);
s.gazeLeft.y=lowPassFilter(bandpass,s.gazeLeft.y,1000);
end

if trials
    indexes=[];
    %put you trial start times here (in indexes)
    for i=1:10000
        if ~isempty(s.inputs(i).input)
            switch s.inputs(i).input
                case trial_start_code %the trial start code here
                    indexes=[indexes,s.inputs(i).time];
                    
            end
        end
    end
else
    
    indexes=[seglen:seglen:length(s.gazeRight.x)-seglen];
end

for iTrial=1:length(indexes)
    if trials
            seg_start_ind=find(indexes(iTrial)==s.gazeRight.time);
            seg_end_ind=seg_start_ind+seglen;
    else
   
     seg_start_ind=indexes(iTrial)-baseline;
    seg_end_ind=indexes(iTrial)+seglen;
    end
  
    if ~isempty (seg_end_ind)
        dataXR=s.gazeRight.x(seg_start_ind:seg_end_ind-1);
        dataYR=s.gazeRight.y(seg_start_ind:seg_end_ind-1);
        dataXL=s.gazeLeft.x(seg_start_ind:seg_end_ind-1);
        dataYL=s.gazeLeft.y(seg_start_ind:seg_end_ind-1);
        blinksseg=blinks(seg_start_ind:seg_end_ind-1);
        
        d= [(1:length(dataXR))' dataXR' dataYR' dataXL' dataYL' blinksseg];
        
        [onsets offsets amplitudes vels] = getSaccadesSegNoBlinks(d,1000,'lab');  %<==== function call here
        sacOnsetsSession(iTrial,onsets(amplitudes<amplitudelim))=1;  
        amplitudescheck(iTrial,onsets(amplitudes<amplitudelim))=amplitudes(amplitudes<amplitudelim); 
        velscheck(iTrial,onsets(amplitudes<amplitudelim))=vels(amplitudes<amplitudelim);  
        for k=1:length(onsets)
            deltax=DPP*(dataXR(onsets(k))-dataXR(offsets(k)));%calculated deltax in degrees
            deltay=DPP*(dataYR(onsets(k))-dataYR(offsets(k)));
            
            allsacps=[allsacps;iTrial,onsets(k),offsets(k),amplitudes(k),vels(k),seg_start_ind+onsets(k),0,deltax,deltay];
        end
        if eyeball
            %figure;
            plot((1:length(dataXR)),dataXR,(1:length(dataXR)),dataXL,(1:length(dataYR)),dataYR,(1:length(dataXR)),dataYL)
            legend('Rx','Lx','Ry','Ly')
            hold on
            plot(onsets,dataXR(onsets),'xr')
           
            pause(.1)
            %title(num2str(amplitudes'/60))
            %s=input('r');
            hold off
            
            keyboard
        else
            
            
            if iTrial<21
                hold on
                subplot(4,5,iTrial)
                plot((1:length(dataXR)),dataXR,(1:length(dataXR)),dataXL,(1:length(dataYR)),dataYR,(1:length(dataXR)),dataYL)
            hold on
            plot(onsets(amplitudes<amplitudelim),dataXR(onsets(amplitudes<amplitudelim)),'xr')
            ylim([200,770]);
            %yzero = plot([ 100 100], get(gca,'ylim'),'r: '); % yline T2 lag 1

         

            
            %plot([10,10],[boxess{iTrial}(3,1),boxess{iTrial}(3,3)],'r-')
            %plot([10,10],[boxes(3,1),boxes(3,3)],'r-')
            %yzero = plot([ (elgabonsettime(iTrial)-elstarttime(i)) (elgabonsettime(iTrial)-elstarttime(i))], get(gca,'ylim'),'k:'); % yline
            end
        end
        
        %rmss=[rmss mean([rms(fixxseg(iTrial,:)),rms(fixyseg(iTrial,:))])];
        
    end
end

if mainseq
sacs=reshape(sacOnsetsSession,1,size(sacOnsetsSession,1)*size(sacOnsetsSession,2));
amps=reshape(amplitudescheck,1,size(sacOnsetsSession,1)*size(sacOnsetsSession,2));
vels=reshape(velscheck,1,size(sacOnsetsSession,1)*size(sacOnsetsSession,2));

amps=amps(find(sacs));
vels=vels(find(sacs));
figure
plot(amps,vels,'x')
xlabel('amplitude')
ylabel('velocity')

end

[r,p]=corr(vels',amps')

