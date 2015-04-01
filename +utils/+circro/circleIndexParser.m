function p = circleIndexParser(parserFn, v)

    circleState = utils.circro.getCircleState();
        
	p = parserFn(circleState);
    
    circleIndex = p.Results.circleIndex;
    if circleIndex <= utils.circro.maxCircleIndex(v)
        circleState = utils.circro.getCircleState(v.circles{circleIndex});
    end
    
	p = parserFn(circleState, circleIndex);
end
