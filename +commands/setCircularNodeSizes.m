function setCircularNodeSizes(v, sizesFullPath)
nodeSizes = fileUtils.loadSizes(sizesFullPath);
v.nodeSizes=nodeSizes;
numNodeSize=numel(nodeSizes);
nodeSizes(1:numNodeSize/2,2)=flipud(((numNodeSize/2)+1:numNodeSize)'); % here in case I decide to add display values in the future
if isfield(v,'labels')
    labels=v.labels; % nodes were previously selected
else
    temp=[(1:numNodeSize/2)' flipud((((numNodeSize/2)+1):numNodeSize)')]; % nodes were not previously selected- assigning names
    labels=(num2cell(temp));
end
nodeSizes=v.nodeSizes;
guidata(v.hMainFigure,v)
drawing.drawCircle(v, labels,nodeSizes);
fprintf('Drawing circle with %d regions\n',numel(labels))
if exist('labels','var')
    drawing.writeNames(labels,(1+max(nodeSizes(:))),pi/2);
end
