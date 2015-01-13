function setEdgeThreshold(v, edgeThreshold)
    v.edgeThreshold =edgeThreshold;
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircle(v);
    
% end select colors data
