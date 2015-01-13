function setNodeLabels(v, labelsFullPath, varargin)
    inputs = parseInputsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    
    v.circles{circleIndex}.nodeLabels=fileUtils.circro.loadLabels(labelsFullPath);
    guidata(v.hMainFigure,v)
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputsSub(v, args)
    p = inputParser;
    if isfield(v, 'circles')
        d.circleIndex = length(v.circles);
    else
        d.circleIndex = 1;
    end
    
    p.addOptional('circleIndex', d.circleIndex, ...
        @(x) validateattributes(x, {'numeric'}, {'integer', 'positive'}));
    
    p = utils.stringSafeParse(p, args, fieldnames(d), d.circleIndex);
    
    inputParams = p.Results;
end