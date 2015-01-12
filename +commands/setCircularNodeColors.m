function setCircularNodeColors(v, colors_full_path)
    [value_colors, ~]=xlsread(colors_full_path);
    v.value_colors=value_colors; 
    
    num_value_colors=numel(value_colors);
    size_value_colors=size(value_colors);
    
    if isfield(v,'labels')
        labels=v.labels; % nodes were previously selected
    else
        temp=[(1:num_value_colors/2)' flipud((((num_value_colors/2)+1):num_value_colors)')]; % nodes were not previously selected- assigning names
        labels=(num2cell(temp));
    end
    value_colors=v.value_colors;
    
    guidata(v.hMainFigure,v)
    
    fprintf('Drawing circle with %d regions\n',numel(value_colors))
    if isfield(v,'node_sizes')
        node_sizes=v.node_sizes;
        drawing.draw_circle(v, labels,node_sizes); %sizes were previously selected
    else
        drawing.draw_circle(v, labels,(ones(size_value_colors))/4,value_colors)
    end
    if exist('labels','var')
        drawing.writeNames(labels,(1+max(value_colors(:))),pi/2);
    end
% end select colors data
