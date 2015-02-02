function toggleLabels(v, varargin)
    inputs = parseInputParamsSub(v, varargin);
    
    circleIndex = inputs.circleIndex;
    
    circleState = utils.circro.getCircleState(v.circles{circleIndex});
    
    v.circles{circleIndex}.showLabels = ~circleState.drawLabels;

    guidata(v.hMainFigure,v);
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)
    p = inputParser;
    
    d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);

    p = utils.stringSafeParse(p, args, fieldnames(d), d.circleIndex);

    inputParams = p.Results;

end