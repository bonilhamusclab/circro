function setNodeColors(v, colorsFullPath)
    v.nodeColors =fileUtils.circro.loadColors(colorsFullPath);
    
    guidata(v.hMainFigure,v);
    
    drawing.circro.drawCircle(v);
    
% end select colors data
