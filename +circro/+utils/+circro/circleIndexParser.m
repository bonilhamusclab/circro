function p = circleIndexParser(parserFn, v)

    circleState = circro.utils.circro.getCircleState();
        
	p = parserFn(circleState);
    
    circleIndex = p.Results.circleIndex;
    if circleIndex <= circro.utils.circro.maxCircleIndex(v)
        circleState = circro.utils.circro.getCircleState(v.circles{circleIndex});
    end
    
	p = parserFn(circleState, circleIndex);
end
