function setNodeColors(v, colorsFullPath, circleIndex)
    if nargin < 3
        if isfield(v, 'circles')
            circleIndex = length(v.circles);
        else
            circleIndex = 1;
        end
    end
    
    validateattributes(circleIndex, {'numeric'}, {'integer', 'positive'});
    
    v.circles{circleIndex}.nodeColors =fileUtils.circro.loadColors(colorsFullPath);
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircles(v);
    
% end select colors data
