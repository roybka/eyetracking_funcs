function [types, counts]=type_freq_ET(struct)

types=[];
counts=[];
vec=[];
i=1;
while ~isempty(struct(i).time)
    if struct(i).input~=0
        vec=[vec struct(i).input];
    end
    i=i+1;
end
   [types,counts]=type_freq(vec);
[counts,ind]=sort(counts);
types=types(ind);