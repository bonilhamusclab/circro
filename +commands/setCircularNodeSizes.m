function setCircularNodeSizes(v, sizesFullPath)
nodeSizes = fileUtils.loadSizes(sizesFullPath);
v.node_sizes=nodeSizes;
num_node_size=numel(nodeSizes);
nodeSizes(1:num_node_size/2,2)=flipud(((num_node_size/2)+1:num_node_size)'); % here in case I decide to add display values in the future
if isfield(v,'lables')
    labels=v.labels; % nodes were previously selected
else
    temp=[(1:num_node_size/2)' flipud((((num_node_size/2)+1):num_node_size)')]; % nodes were not previously selected- assigning names
    labels=(num2cell(temp));
end
nodeSizes=v.node_sizes;
guidata(v.hMainFigure,v)
drawing.draw_circle(v, labels,nodeSizes);
fprintf('Drawing circle with %d regions\n',numel(labels))
if exist('labels','var')
    drawing.writeNames(labels,(1+max(nodeSizes(:))),pi/2);
end
