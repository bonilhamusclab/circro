function setEdgeMatrix(v, edgeMatrixFullPath, varargin)

    matrix = circro.fileUtils.circro.loadMatrix(edgeMatrixFullPath);

    inputs = parseInputParamsSub(v, varargin);
    threshold = inputs.threshold;
    circleIndex = inputs.circleIndex;

    v.circles{circleIndex}.edgeMatrix = matrix;
    v.circles{circleIndex}.edgeThreshold = threshold;

    if inputs.colorscheme
        v.circles{circleIndex}.edgeColorscheme = inputs.colorscheme;
    end

    guidata(v.hMainFigure,v);
    drawing.circro.drawCircles(v);
end


function inputParams = parseInputParamsSub(v, args)

    function p = runParser(circleState, ~)
        p = inputParser;
        d.threshold = circleState.edgeThreshold;
        d.colorscheme = circleState.edgeColorscheme;
        d.alpha = circleState.edgeAlpha;

        p.addOptional('threshold', d.threshold, @(x) validateattributes(x, {'numeric'},{'real'}));
        p.addOptional('colorscheme', d.colorscheme, ...
            utils.validOrEmptyFnGen(utils.colorMapNames, 'setEdgeMatrix', 'colorscheme'));
        p.addOptional('alpha', d.alpha, ...
            @(x) validateattributes(x, {'numeric'}, {'<=' 1, '>=', 0}));
        
        d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);

        p = utils.stringSafeParse(p, args, fieldnames(d), ...
            d.threshold, d.colorscheme, d.circleIndex);
    end

    p = utils.circro.circleIndexParser(@runParser, v);

    inputParams = p.Results;
end