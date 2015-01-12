function setCircularNodeColors(v, colorsFullPath)
    [valueColors, ~]=xlsread(colorsFullPath);
    v.valueColors=valueColors; 
    
    numValueColors=numel(valueColors);
    sizeValueColors=size(valueColors);
    
    if isfield(v,'labels')
        labels=v.labels; % nodes were previously selected
    else
        temp=[(1:numValueColors/2)' flipud((((numValueColors/2)+1):numValueColors)')]; % nodes were not previously selected- assigning names
        labels=(num2cell(temp));
    end
    valueColors=v.valueColors;
    
    guidata(v.hMainFigure,v)
    
    fprintf('Drawing circle with %d regions\n',numel(valueColors))
    if isfield(v,'nodeSizes')
        nodeSizes=v.nodeSizes;
        drawing.drawCircle(v, labels,nodeSizes); %sizes were previously selected
    else
        drawing.drawCircle(v, labels,(ones(sizeValueColors))/4,valueColors)
    end
    if exist('labels','var')
        drawing.writeLabels(labels,(1+max(valueColors(:))),pi/2);
    end
% end select colors data
