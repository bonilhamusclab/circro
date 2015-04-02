function editEdgeColorSettings(v, varargin)
    
    inputs = parseInputParamsSub(v, varargin);
    circleIndex = inputs.circleIndex;
    
    v.circles{circleIndex}.edgeColorscheme = inputs.edgeColorscheme;
    v.circles{circleIndex}.edgeAlpha = inputs.edgeAlpha;
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)

    function p = runParser(circleState, ~)
        p = inputParser;
        
        d.edgeColorscheme = circleState.edgeColorscheme;
        d.edgeAlpha = circleState.edgeAlpha;
        
        p.addOptional('edgeColorscheme', d.edgeColorscheme, ...
            utils.validOrEmptyFnGen(utils.colorMapNames, 'setEdgeMatrixColorSettings', 'colorscheme'));
        p.addOptional('edgeAlpha', d.edgeAlpha, ...
            @(x) validateattributes(x, {'numeric'}, {'<=' 1, '>=', 0}));

        d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);

        p = utils.stringSafeParse(p, args, fieldnames(d), ...
            d.edgeColorscheme, d.edgeAlpha, d.circleIndex);
    end

    p = utils.circro.circleIndexParser(@runParser, v);

    inputParams = p.Results;
end
