function setNodeSizes(v, sizes_full_path)
node_sizes = fileUtils.loadSizes(sizes_full_path);
v.node_sizes=node_sizes;
guidata(v.hMainFigure,v)
