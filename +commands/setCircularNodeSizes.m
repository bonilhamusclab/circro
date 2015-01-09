function setCircularNodeSizes(v, sizesFullPath)
nodeSizes = fileUtils.loadSizes(sizesFullPath);
v.node_sizes=nodeSizes;
num_node_size=numel(nodeSizes);
nodeSizes(1:num_node_size/2,2)=flipud(((num_node_size/2)+1:num_node_size)'); % here in case I decide to add display values in the future
if isfield(v,'list_regions')
    list_regions=v.list_regions; % nodes were previously selected
else
    temp=[(1:num_node_size/2)' flipud((((num_node_size/2)+1):num_node_size)')]; % nodes were not previously selected- assigning names
    list_regions=(num2cell(temp));
end
nodeSizes=v.node_sizes;
guidata(v.hMainFigure,v)
drawing.draw_circle(v, list_regions,nodeSizes);
fprintf('Drawing circle with %d regions\n',numel(list_regions))
if exist('list_regions','var')
    drawing.write_names(list_regions,(1+max(nodeSizes(:))),pi/2);
end
