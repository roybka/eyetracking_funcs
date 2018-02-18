function [ ] = makeedfs( filestr )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(filestr)
    
eval(strcat(filestr{i},'=readEDF(',char(39),filestr{i},'.edf',char(39),')'))
save(filestr{i})
eval(filestr('clear( ',char(39),filestr{i},char(39),')'))
end

end

