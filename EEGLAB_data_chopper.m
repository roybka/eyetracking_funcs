%eeg data chopping
b=[];
for i=1:3102
if EEG.urevent(i).type==66
b=[b i];
end
end

start=1000*413.25
ending=1000*1620.1
1620.1
first_latency=423165;%422881;
%first_samp=first_latency*1024;

last_latency=1658993;%1663521;

%last_samp=last_latency*1024;

a=find(EEG.times<last_latency);
c=find(EEG.times>first_latency);

beg_ind=c(1);
end_ind=a(end);

EEG.data=EEG.data(:,beg_ind:end_ind);
EEG.times=EEG.times(beg_ind:end_ind);

%find time matching events:
tog1=0;
tog2=0;
for i=1:3102
if EEG.urevent(i).latency>first_latency &~tog1
tog1=1;
first_event=i;
end
if EEG.urevent(i).latency>last_latency &~tog2
tog2=1;
last_event=i-1;
end
end


EEG.event=EEG.event(first_event:last_event);
EEG.urevent=EEG.urevent(first_event:last_event);

EEG.pnts=length(EEG.times);