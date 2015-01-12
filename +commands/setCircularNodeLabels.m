function setCircularNodeLabels(v, labelsFullPath)
    labels=fileUtils.loadLabels(labelsFullPath);
    
    v.number_labels=numel(labels); 
    v.labels=labels;
    guidata(v.hMainFigure,v)
    drawing.draw_circle(v, labels); % write circle with the regions listed
    drawing.write_names(labels,1.2,pi/2);
end