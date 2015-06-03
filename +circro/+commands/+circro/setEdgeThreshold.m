function setEdgeThreshold(v, edgeThreshold, varargin)
    validateattributes(edgeThreshold, {'numeric'}, {'real'});
    
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    
    v.circles{circleIndex}.edgeThreshold = edgeThreshold;
    
    guidata(v.hMainFigure,v);
    
    circro.drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)
    p = inputParser;
    
    d.circleIndex = circro.utils.circro.addCircleIndexInputCheck(v, p);

    p = circro.utils.stringSafeParse(p, args, fieldnames(d), ...
        d.circleIndex);

    inputParams = p.Results;
end