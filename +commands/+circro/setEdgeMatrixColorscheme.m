function setEdgeMatrixColorscheme(v, colorscheme, varargin)
    validatestring(colorscheme, utils.colorMapNames);
    
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    
    colorscheme = str2func(colorscheme);
    
    v.circles{circleIndex}.edgeMatrixColorscheme = colorscheme();
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)
    p = inputParser;
    
    d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);

    p = utils.stringSafeParse(p, args, fieldnames(d), ...
        d.circleIndex);

    inputParams = p.Results;
end