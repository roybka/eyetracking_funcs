function [realones]=singular_events(vec,n)
%this function gets an EL mat array and returns saccades list without redundancies. 
cands=vec;

realones=[];
for i=1:length(cands)
%     probe=i-5:i+5;
%     probe=probe(probe>0&probe<length(cands))
if ~any(abs(realones-cands(i))<n)
    realones=[realones cands(i)];
    
end
end
realones=realones(1:end);