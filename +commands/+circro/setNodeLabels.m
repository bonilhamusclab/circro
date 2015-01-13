function setNodeLabels(v, labelsFullPath)
    v.nodeLabels=fileUtils.circro.loadLabels(labelsFullPath);
    guidata(v.hMainFigure,v)
    drawing.drawCircle(v);
end
