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
    
    fprintf('Drawing circle with %d regions\n',numel(valueColors))
    if ~isfield(v,'nodeSizes')
        v.nodeSizes = (ones(sizeValueColors))/4;
    end
    
    guidata(v.hMainFigure,v);
    
    drawing.drawCircle(v, valueColors);
    
% end select colors data
