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
    
    if isfield(v, 'circles') && ~isempty(v.circles)
        d.circleIndex = length(v.circles);
    else
        d.circleIndex = 1;
    end
    
    d.colorscheme = '';

    p.addOptional('circleIndex', d.circleIndex, ...
      @(x) validateattributes(x, {'numeric'}, {'integer', 'positive'}));
    p.addOptional('colorscheme', d.colorscheme, ...
        utils.validOrEmptyFnGen(utils.colorMapNames, 'setNodeColors', 'colorscheme'));

    p = utils.stringSafeParse(p, args, fieldnames(d), ...
        d.circleIndex, d.colorscheme);

    inputParams = p.Results;
end