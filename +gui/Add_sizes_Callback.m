% --- add a circle with default options
function Add_sizes_Callback(obj, ~)
v=guidata(obj);
Select_size_data(v);
v=guidata(obj);
value_sizes=v.value_sizes;
num_value_size=numel(value_sizes);
list_value_sizes(1:num_value_size/2,2)=flipud(((num_value_size/2)+1:num_value_size)'); % here in case I decide to add display values in the future
if isfield(v,'list_regions')
    list_regions=v.list_regions; % nodes were previously selected
else
    temp=[(1:num_value_size/2)' flipud((((num_value_size/2)+1):num_value_size)')]; % nodes were not previously selected- assigning names
    list_regions=(num2cell(temp));
end
value_sizes=v.value_sizes;
drawing.draw_circle(v, list_regions,value_sizes);
fprintf('Drawing circle with %d regions\n',numel(list_regions))
if exist('list_regions','var')
    write_names(list_regions,(1+max(value_sizes(:))),pi/2);
end
%end Add_sizes_Callback()
