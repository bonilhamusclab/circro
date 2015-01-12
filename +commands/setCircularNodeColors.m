function setCircularNodeColors(v, colorsFullPath)
    [valueColors, ~]=xlsread(colorsFullPath);
    v.valueColors=valueColors; 
    
    numValueColors=numel(valueColors);
    sizeValueColors=size(valueColors);
    
    if ~isfield(v,'labels') % labels were not previously set
        temp=[(1:numValueColors/2)' flipud((((numValueColors/2)+1):numValueColors)')]; % nodes were not previously selected- assigning names
        v.labels=(num2cell(temp));
    end
    valueColors=v.valueColors;
    
    guidata(v.hMainFigure,v)
    
    fprintf('Drawing circle with %d regions\n',numel(valueColors))
    if isfield(v,'nodeSizes')
        nodeSizes=v.nodeSizes;
        drawing.drawCircle(v, nodeSizes); %sizes were previously selected
    else
        drawing.drawCircle(v, (ones(sizeValueColors))/4,valueColors)
    end
% end select colors data
