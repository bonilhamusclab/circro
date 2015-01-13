function setCircularDimensions(v, radius, labelRadius, startRadian)

if nargin > 1
    validateattributes(radius, {'numeric'}, {'positive', 'real'});
    v.radius = radius;
end

if nargin > 2
    validateattributes(labelRadius, {'numeric'}, {'positive', 'real'});
    v.labelRadius = labelRadius;
end

if nargin > 3
    validateattributes(startRadian, {'numeric'}, {'real'});
    v.startRadian = startRadian;
end

guidata(v.hMainFigure,v);
drawing.drawCircle(v);