function setCircularNodeLabels(v, labelsFullPath)
    labels=fileUtils.loadLabels(labelsFullPath);
    
    v.numberLabels=numel(labels); 
    v.labels=labels;
    guidata(v.hMainFigure,v)
    drawing.drawCircle(v, labels); % write circle with the regions listed
    drawing.writeNames(labels,1.2,pi/2);
end