function setNodeColors(v, colorsFullPath, varargin)
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    colorscheme = inputs.colorscheme;
    alhpa = inputs.alpha;
    
    v.circles{circleIndex}.nodeColors = circro.fileUtils.circro.loadColors(colorsFullPath);
    
    v.circles{circleIndex}.nodeColorscheme = colorscheme;
    v.circles{circleIndex}.nodeAlpha = alhpa;
    
    guidata(v.hMainFigure,v);
    
    circro.drawing.circro.drawCircles(v);
    
end

function inputParams = parseInputParamsSub(v, args)

    function p = runParser(circleState, ~)
        
        p = inputParser;

        d.colorscheme = circleState.nodeColorscheme;
        d.alpha = circleState.nodeAlpha;

        p.addOptional('colorscheme', d.colorscheme, ...
            circro.utils.validOrEmptyFnGen(v.colorMapNames, 'setNodeColors', 'colorscheme'));
        
        p.addOptional('alpha', d.alpha, ...
            @(x) validateattributes(x, {'numeric'}, {'<=' 1, '>=', 0}));

        d.circleIndex = circro.utils.circro.addCircleIndexInputCheck(v, p);

        p = circro.utils.stringSafeParse(p, args, fieldnames(d), ...
            d.colorscheme, d.alpha, d.circleIndex);
    end

    p = circro.utils.circro.circleIndexParser(@runParser, v);

    inputParams = p.Results;
end
