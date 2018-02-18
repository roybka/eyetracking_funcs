function [types, counts]=type_freq(vec)
types=[];
counts=[];
for i=1:length(vec)
    if ~ismember(vec(i),types)
        types=[types vec(i)];
        counts=[counts 1];
    else
       counts(find(types==vec(i)))= counts(find(types==vec(i)))+1;
    end
end
