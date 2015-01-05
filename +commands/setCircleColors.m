function setCircleColors(v, colors_full_path)
    [value_colors, ~]=xlsread(colors_full_path);
    v.value_colors=value_colors; 
    
    num_value_colors=numel(value_colors);
    size_value_colors=size(value_colors);
    
    if isfield(v,'list_regions')
        list_regions=v.list_regions; % nodes were previously selected
    else
        temp=[(1:num_value_colors/2)' flipud((((num_value_colors/2)+1):num_value_colors)')]; % nodes were not previously selected- assigning names
        list_regions=(num2cell(temp));
    end
    value_colors=v.value_colors;
    
    guidata(v.hMainFigure,v)
    
    fprintf('Drawing circle with %d regions\n',numel(value_colors))
    if isfield(v,'node_sizes')
        node_sizes=v.node_sizes;
        drawing.draw_circle(v, list_regions,node_sizes); %sizes were previously selected
    else
        drawing.draw_circle(v, list_regions,(ones(size_value_colors))/4,value_colors)
    end
    if exist('list_regions','var')
        drawing.write_names(list_regions,(1+max(value_colors(:))),pi/2);
    end
% end select colors data
