function setNodeSizes(v, sizesFullPath, varargin)
inputParams = parseInputParamsSub(v, varargin);
circleIndex = inputParams.circleIndex;

v.circles{circleIndex}.nodeSizes = fileUtils.circro.loadSizes(sizesFullPath);

guidata(v.hMainFigure,v)
drawing.circro.drawCircles(v);

end

function inputParams = parseInputParamsSub(v, args)
    p = inputParser;
    
    d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);
    
    p = utils.stringSafeParse(p, args, fieldnames(d), d.circleIndex);
    
    inputParams = p.Results;
end