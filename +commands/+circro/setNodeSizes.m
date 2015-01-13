function setNodeSizes(v, sizesFullPath, varargin)
inputParams = parseInputParamsSub(v, varargin);
circleIndex = inputParams.circleIndex;

v.circles{circleIndex}.nodeSizes = fileUtils.circro.loadSizes(sizesFullPath);

guidata(v.hMainFigure,v)
drawing.circro.drawCircles(v);

end

function inputParams = parseInputParamsSub(v, args)
    d = {};
    if isfield(v, 'circles')
        d.circleIndex = length(v.circles);
    else
        d.circleIndex = 1;
    end
    
    p = inputParser;
    
    p.addOptional('circleIndex', d.circleIndex, ...
        @(x) validateattributes(x, {'numeric'}, {'integer', 'positive'}));
    
    p = utils.stringSafeParse(p, args, fieldnames(d), d.circleIndex);
    
    inputParams = p.Results;
end