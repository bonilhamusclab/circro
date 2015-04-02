function editEdgeColorSettings(v, varargin)
    
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    
    v.circles{circleIndex}.edgeColorscheme = inputs.colorscheme;
    v.circles{circleIndex}.edgeAlpha = inputs.alpha;
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)

    function p = runParser(circleState, ~)
        p = inputParser;
        
        d.colorscheme = circleState.edgeColorscheme;
        d.alpha = circleState.edgeAlpha;
        
        p.addOptional('colorscheme', d.colorscheme, ...
            utils.validOrEmptyFnGen(utils.colorMapNames, 'setEdgeMatrixColorSettings', 'colorscheme'));
        p.addOptional('alpha', d.alpha, ...
            @(x) validateattributes(x, {'numeric'}, {'<=' 1, '>=', 0}));

        d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);

        p = utils.stringSafeParse(p, args, fieldnames(d), ...
            d.colorscheme, d.alpha, d.circleIndex);
    end

    p = utils.circro.circleIndexParser(@runParser, v);

    inputParams = p.Results;
end
