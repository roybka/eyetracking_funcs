function []=show_all_commands(ALLCOM)
for i=1:length(ALLCOM)
    disp(ALLCOM{length(ALLCOM)-(i-1)})
end
end