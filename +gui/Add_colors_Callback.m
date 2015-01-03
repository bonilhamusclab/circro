% --- Add colors
function Add_colors_Callback(obj, ~)
v=guidata(obj);
Select_colors_data(v);
v=guidata(obj);
value_colors=v.value_colors;
num_value_colors=numel(value_colors);
size_value_colors=size(value_colors);
list_value_colors(1:num_value_colors/2,2)=flipud(((num_value_colors/2)+1:num_value_colors)'); % here in case I decide to add display values in the future
if isfield(v,'list_regions')
    list_regions=v.list_regions; % nodes were previously selected
else
    temp=[(1:num_value_colors/2)' flipud((((num_value_colors/2)+1):num_value_colors)')]; % nodes were not previously selected- assigning names
    list_regions=(num2cell(temp));
end
value_colors=v.value_colors;
fprintf('Drawing circle with %d regions\n',numel(value_colors))
if isfield(v,'value_sizes')
    value_sizes=v.value_sizes;
    drawing.draw_circle(list_regions,v,value_sizes); %sizes were previously selected
else
    drawing.draw_circle(list_regions,v,(ones(size_value_colors))/4,value_colors)
end
if exist('list_regions','var')
    write_names(list_regions,(1+max(value_colors(:))),pi/2);
end
% end Add colors;
