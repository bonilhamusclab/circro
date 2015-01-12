function setCircularNodeColors(v, colorsFullPath)
    nodeColors =fileUtils.loadColors(colorsFullPath);
    v.nodeColors=nodeColors; 
    
    numNodeColors=numel(nodeColors);
    
    if ~isfield(v,'labels') % labels were not previously set
        temp=[(1:numNodeColors/2)' flipud((((numNodeColors/2)+1):numNodeColors)')]; % nodes were not previously selected- assigning names
        v.labels=(num2cell(temp));
    end
    nodeColors=v.nodeColors;
    
    fprintf('Drawing circle with %d regions\n',numel(nodeColors))
    
    guidata(v.hMainFigure,v);
    
    drawing.drawCircle(v);
    
% end select colors data
