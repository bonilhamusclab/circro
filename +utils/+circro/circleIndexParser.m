function p = circleIndexParser(parserFn)
	p = parserFn();
	p = parserFn(p.Results.circleIndex);
end
