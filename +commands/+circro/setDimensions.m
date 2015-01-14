function setDimensions(v, varargin)
    inputs = parseInputParamsSub(v, varargin);
    radius = inputs.radius;
    labelRadius = inputs.labelRadius;
    startRadian = inputs.startRadian;
    circleIndex = inputs.circleIndex;

    if radius > -inf
        validateattributes(radius, {'numeric'}, {'positive', 'real'});
        v.circles{circleIndex}.radius = radius;
    end

    if labelRadius > -inf
        validateattributes(labelRadius, {'numeric'}, {'positive', 'real'});
        v.circles{circleIndex}.labelRadius = labelRadius;
    end

    if startRadian > -inf
        validateattributes(startRadian, {'numeric'}, {'real'});
        v.circles{circleIndex}.startRadian = startRadian;
    end

    guidata(v.hMainFigure,v);
    drawing.circro.drawCircles(v);
end

function inputParams = parseInputParamsSub(v, args)
    p = inputParser;
    d.radius = -inf; d.labelRadius = -inf; d.startRadian = -inf;
    if isfield(v, 'circles')
        d.circleIndex = length(v.circles);
    else
        d.circleIndex = 1;
    end
        

    p.addOptional('radius', d.radius, @(x) validateattributes(x, {'numeric'}, {'real'}));
    p.addOptional('labelRadius', d.labelRadius, @(x) validateattributes(x, {'numeric'}, {'real'}));
    p.addOptional('startRadian', d.startRadian, @(x) validateattributes(x, {'numeric'}, {'real'}));
    p.addOptional('circleIndex', d.circleIndex, @(x) validateattributes(x, {'numeric'}, {'integer', 'positive'}));

    p = utils.stringSafeParse(p, args, fieldnames(d), ...
        d.radius, d.labelRadius, d.startRadian);

    inputParams = p.Results;

end