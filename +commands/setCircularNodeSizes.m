function setCircularNodeSizes(v, sizesFullPath)
nodeSizes = fileUtils.loadSizes(sizesFullPath);
v.nodeSizes=nodeSizes;
numNodeSize=numel(nodeSizes);
if ~isfield(v,'labels')
    temp=[(1:numNodeSize/2)' flipud((((numNodeSize/2)+1):numNodeSize)')]; % nodes were not previously selected- assigning names
    v.labels=(num2cell(temp));
end
nodeSizes=v.nodeSizes;
guidata(v.hMainFigure,v)
drawing.drawCircle(v, nodeSizes);