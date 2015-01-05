function addEdgeMatrix(v, matrix_full_path, threshold, start_radian, radius)
matrix = fileUtils.loadMatrix(matrix_full_path);
v.matrix=matrix;     

% number_links=size(matrix,1);
% % check if list regions previously defined
% if isfield(v,'list_regions')
%     list_regions=v.list_regions; % nodes were previously selected
% else
%     temp=[(1:number_links/2)' flipud((((number_links/2)+1):number_links)')]; % nodes were not previously selected- assigning names
%     list_regions=(num2cell(temp));
% end
% % check if sizes previously defined
% if isfield(v,'node_sizes')
%     node_sizes=v.list_regions; % nodes were previously selected
% else
%     temp=[(1:num_value_colors/2)' flipud((((num_value_colors/2)+1):num_value_colors)')]; % nodes were not previously selected- assigning names
%     list_regions=(num2cell(temp));
% end


guidata(v.hMainFigure,v);
drawing.draw_links(matrix,threshold,start_radian,radius);
