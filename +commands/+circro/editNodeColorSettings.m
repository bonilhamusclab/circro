function editNodeColorSettings(v, varargin)
    
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
	alpha = inputs.alpha;
    colorscheme = inputs.colorscheme;
    
    v.circles{circleIndex}.nodeColorscheme = colorscheme;
	v.circles{circleIndex}.nodeAlpha = alpha;
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)

    function p = runParser(circleState, ~)
        
        d.nodeAlpha = circleState.nodeAlpha;
        d.colorscheme = circleState.nodeColorscheme;
        
        p = inputParser;
        
        p.addOptional('colorscheme', d.colorscheme, ...
            utils.validOrEmptyFnGen(utils.colorMapNames, 'editNodeColorSettings', 'colorscheme'));
        
        nodeAlphaValidateFn = @(x) validateattributes(x, {'numeric'}, {'<=' 1, '>=', 0});
        p.addOptional('alpha', d.nodeAlpha, nodeAlphaValidateFn);
    
        d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);

        p = utils.stringSafeParse(p, args, fieldnames(d), ...
            d.colorscheme, d.nodeAlpha, d.circleIndex);
    end

    p = utils.circro.circleIndexParser(@runParser, v);
    
    inputParams = p.Results;
end
