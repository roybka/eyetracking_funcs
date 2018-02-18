function [ meanr ] = mean_corr( r )
% this function returns mean correlation coefficient from a vector of
% correlations.
if any(size(r)==1)
meanr=ifisherz(mean(fisherz(r)));
else
    for j=1:size(r,2)
        meanr(j)=ifisherz(mean(fisherz(r(:,j))));

    end
end

end

