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
    
    if isfield(v, 'circles')
        d.circleIndex = length(v.circles);
    else
        d.circleIndex = 1;
    end
        
    p.addOptional('circleIndex', d.circleIndex, @(x) validateattributes(x, {'numeric'}, {'integer', 'positive'}));

    p = utils.stringSafeParse(p, args, fieldnames(d), d.circleIndex);

    inputParams = p.Results;

end