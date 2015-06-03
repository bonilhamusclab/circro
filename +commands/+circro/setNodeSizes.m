function setNodeSizes(v, sizesFullPath, varargin)
inputParams = parseInputParamsSub(v, varargin);
circleIndex = inputParams.circleIndex;

v.circles{circleIndex}.nodeSizes = circro.fileUtils.circro.loadSizes(sizesFullPath);

guidata(v.hMainFigure,v)
drawing.circro.drawCircles(v);

end

function inputParams = parseInputParamsSub(v, args)
    p = inputParser;
    
    d.circleIndex = circro.utils.circro.addCircleIndexInputCheck(v, p);
    
    p = circro.utils.stringSafeParse(p, args, fieldnames(d), d.circleIndex);
    
    inputParams = p.Results;
end