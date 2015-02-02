function defCircleIndex = addCircleIndexInputCheck(v, p)
	if isfield(v, 'circles') && ~isempty(v.circles)
		defCircleIndex = length(v.circles);
		maxCircleIndex = defCircleIndex + 1;
	else
		defCircleIndex = 1;
		maxCircleIndex = defCircleIndex;
	end

	p.addOptional('circleIndex', defCircleIndex, ...
	      @(x) validateattributes(x, {'numeric'}, {'integer', 'positive', '<=', maxCircleIndex}));
end
