function setNodeColors(v, colorsFullPath, varargin)
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    colorscheme = inputs.colorscheme;
    
    v.circles{circleIndex}.nodeColors = fileUtils.circro.loadColors(colorsFullPath);
    
    if colorscheme
        colorscheme = str2func(colorscheme);
        v.circles{circleIndex}.nodeColorsColorscheme = colorscheme();
    end
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
    
end

function inputParams = parseInputParamsSub(v, args)
    p = inputParser;
    
    d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);
    
    d.colorscheme = '';

    p.addOptional('colorscheme', d.colorscheme, ...
        utils.validOrEmptyFnGen(utils.colorMapNames, 'setNodeColors', 'colorscheme'));

    p = utils.stringSafeParse(p, args, fieldnames(d), ...
        d.circleIndex, d.colorscheme);

    inputParams = p.Results;
end