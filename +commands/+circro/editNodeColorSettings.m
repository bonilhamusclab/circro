function editNodeColorSettings(v, colorscheme, varargin)
    validatestring(colorscheme, utils.colorMapNames);
    
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
	nodeAlpha = inputs.nodeAlpha;
    
    colorscheme = str2func(colorscheme);
    
    v.circles{circleIndex}.nodeColorsColorscheme = colorscheme();
	v.circles{circleIndex}.nodeAlpha = nodeAlpha;
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)

    function p = runParser(circleIndex)
        if nargin > 0
            if circleIndex > utils.circro.maxCircleIndex(v)
                d.nodeAlpha = utils.circro.getCircleState().nodeAlpha;
            else
                d.nodeAlpha = utils.circro.getCircleState(v.circles{circleIndex}).nodeAlpha;
            end
        else
            d.nodeAlpha = .5;
        end
        
        p = inputParser;
        
        nodeAlphaValidateFn = @(x) validateattributes(x, {'numeric'}, {'<=' 1, '>=', 0});
        p.addOptional('nodeAlpha', d.nodeAlpha, nodeAlphaValidateFn);
    
        d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);

        p = utils.stringSafeParse(p, args, fieldnames(d), ...
            d.nodeAlpha, d.circleIndex);
    end

    p = utils.circro.circleIndexParser(@runParser);
    
    inputParams = p.Results;
end
