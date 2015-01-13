function setNodeColors(v, colorsFullPath)
    v.nodeColors =fileUtils.loadColors(colorsFullPath);
    
    guidata(v.hMainFigure,v);
    
    drawing.drawCircle(v);
    
% end select colors data
