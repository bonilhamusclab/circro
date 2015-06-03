function setNodeLabels(v, labelsFullPath, varargin)
    inputs = parseInputsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    
    v.circles{circleIndex}.nodeLabels=circro.fileUtils.circro.loadLabels(labelsFullPath);
    guidata(v.hMainFigure,v)
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputsSub(v, args)
    p = inputParser;
    
    d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);
    
    p = utils.stringSafeParse(p, args, fieldnames(d), d.circleIndex);
    
    inputParams = p.Results;
end