function setCircularEdgeThreshold(v, edgeThreshold)
    v.edgeThreshold =edgeThreshold;
    
    guidata(v.hMainFigure,v);
    
    drawing.drawCircle(v);
    
% end select colors data