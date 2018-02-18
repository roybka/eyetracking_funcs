function [st_times,end_times]=realelsaccades(el)
%this function gets an EL mat array and returns saccades list without redundancies. 
cands=el.saccades.startTime;
endcands=el.saccades.endTime;
sacs=[0];
ends=[0];
for i=1:length(cands)
%     probe=i-5:i+5;
%     probe=probe(probe>0&probe<length(cands))
if ~any(abs(sacs-cands(i))<50)
    sacs=[sacs cands(i)];
    ends=[ends endcands(i)];
end
end
st_times=sacs(2:end);
end_times=ends(2:end);