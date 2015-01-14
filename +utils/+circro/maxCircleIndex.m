function maxIndex = maxCircleIndex(v)
    maxIndex = 1;
    if isfield(v,'circles') && ~isempty(v.('circles'))
    	maxIndex = length(v.circles);
    end
end
