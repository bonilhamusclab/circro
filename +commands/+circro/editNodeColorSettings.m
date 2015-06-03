function editNodeColorSettings(v, varargin)
    
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
	nodeAlpha = inputs.nodeAlpha;
    nodeColorscheme = inputs.nodeColorscheme;
    
    v.circles{circleIndex}.nodeColorscheme = nodeColorscheme;
	v.circles{circleIndex}.nodeAlpha = nodeAlpha;
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)

    function p = runParser(circleState, ~)
        
        d.nodeAlpha = circleState.nodeAlpha;
        d.nodeColorscheme = circleState.nodeColorscheme;
        
        p = inputParser;
        
        p.addOptional('nodeColorscheme', d.nodeColorscheme, ...
            circro.utils.validOrEmptyFnGen(circro.utils.colorMapNames, 'editNodeColorSettings', 'nodeColorscheme'));
        
        nodeAlphaValidateFn = @(x) validateattributes(x, {'numeric'}, {'<=' 1, '>=', 0});
        p.addOptional('nodeAlpha', d.nodeAlpha, nodeAlphaValidateFn);
    
        d.circleIndex = circro.utils.circro.addCircleIndexInputCheck(v, p);

        p = circro.utils.stringSafeParse(p, args, fieldnames(d), ...
            d.nodeColorscheme, d.nodeAlpha, d.circleIndex);
    end

    p = circro.utils.circro.circleIndexParser(@runParser, v);
    
    inputParams = p.Results;
end
