function setCircularNodeLabels(v, labelsFullPath)
    v.nodeLabels=fileUtils.loadLabels(labelsFullPath);
    guidata(v.hMainFigure,v)
    drawing.drawCircle(v);
end