function setNodeColorsColorscheme(v, colorscheme, varargin)
    validatestring(colorscheme, utils.colorMapNames);
    
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    
    colorscheme = str2func(colorscheme);
    
    v.circles{circleIndex}.nodeColorsColorscheme = colorscheme();
    
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

    p.addOptional('circleIndex', d.circleIndex, ...
      @(x) validateattributes(x, {'numeric'}, {'integer', 'positive'}));

    p = utils.stringSafeParse(p, args, fieldnames(d), ...
        d.circleIndex);

    inputParams = p.Results;
end