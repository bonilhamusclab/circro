function setEdgeThreshold(v, edgeThreshold, varargin)
    validateattributes(edgeThreshold, {'numeric'}, {'real'});
    
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    
    v.circles{circleIndex}.edgeThreshold = edgeThreshold;
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)
    p = inputParser;
    
    if isfield(v, 'circles')
        d.circleIndex = length(v.circles);
    else
        d.circleIndex = 1;
    end

    p.addOptional('circleIndex', d.circleIndex, ...
      @(x) validateattributes(x, {'numeric'}, {'integer', 'positive'}));

    p = utils.stringSafeParse(p, args, fieldnames(d), ...
        d.circleIndex);

    inputParams = p.Results;
end