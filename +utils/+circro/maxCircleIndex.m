function maxIndex = maxCircleIndex(v)
    maxIndex = 1;
    if isfield(v, 'circles')
        if ~isempty(v.circles)
            maxIndex = length(v.circles);
        end
    end
end
