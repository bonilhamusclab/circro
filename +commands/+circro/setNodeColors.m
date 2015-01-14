function setNodeColors(v, colorsFullPath, circleIndex)
    if nargin < 3
        circleIndex = 1;
        if isfield(v, 'circles') && ~isempty(v.circles)
            circleIndex = length(v.circles);
        end
    end
    
    validateattributes(circleIndex, {'numeric'}, {'integer', 'positive'});
    
    v.circles{circleIndex}.nodeColors = fileUtils.circro.loadColors(colorsFullPath);
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
    
% end select colors data
