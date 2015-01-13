function setDimensions(v, varargin)
    inputs = parseInputParamsSub(varargin);
    radius = inputs.radius;
    labelRadius = inputs.labelRadius;
    startRadian = inputs.startRadian;

    if radius > -inf
        validateattributes(radius, {'numeric'}, {'positive', 'real'});
        v.radius = radius;
    end

    if labelRadius > -inf
        validateattributes(labelRadius, {'numeric'}, {'positive', 'real'});
        v.labelRadius = labelRadius;
    end

    if startRadian > -inf
        validateattributes(startRadian, {'numeric'}, {'real'});
        v.startRadian = startRadian;
    end

    guidata(v.hMainFigure,v);
    drawing.circro.drawCircle(v);
end

function inputParams = parseInputParamsSub(args)
    p = inputParser;
    d.radius = -inf; d.labelRadius = -inf; d.startRadian = -inf;

    p.addOptional('radius', d.radius, @(x) validateattributes(x, {'numeric'}, {'real'}));
    p.addOptional('labelRadius', d.radius, @(x) validateattributes(x, {'numeric'}, {'real'}));
    p.addOptional('startRadian', d.radius, @(x) validateattributes(x, {'numeric'}, {'real'}));

    p = utils.stringSafeParse(p, args, fieldnames(d), ...
        d.radius, d.labelRadius, d.startRadian);

    inputParams = p.Results;

end
