function maxIndex = maxCircleIndex(v)
%function maxIndex = maxCircleIndex(v)
%returns -1 if no circles yet rendered
    maxIndex = -1;
    if isfield(v,'circles') && ~isempty(v.('circles'))
    	maxIndex = length(v.circles);
    end
end
