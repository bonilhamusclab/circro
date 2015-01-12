function setCircularNodeSizes(v, sizesFullPath)
v.nodeSizes = fileUtils.loadSizes(sizesFullPath);
numNodeSize=numel(v.nodeSizes);
if ~isfield(v,'labels')
    temp=[(1:numNodeSize/2)' flipud((((numNodeSize/2)+1):numNodeSize)')]; % nodes were not previously selected- assigning names
    v.labels=(num2cell(temp));
end
guidata(v.hMainFigure,v)
drawing.drawCircle(v);