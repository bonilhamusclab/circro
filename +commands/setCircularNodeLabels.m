function setCircularNodeLabels(v, labelsFullPath)
    labels=fileUtils.loadLabels(labelsFullPath);
    
    v.numberLabels=numel(labels); 
    v.labels=labels;
    guidata(v.hMainFigure,v)
    drawing.drawCircle(v);
end