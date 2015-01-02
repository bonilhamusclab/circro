% Callback functions
% --- add a circle with default options
function Add_nodes_Callback(obj, ~)
v=guidata(obj);
SelectFileToOpen(v);
v=guidata(obj);
list_regions=v.list_regions;
v.number_region=numel(list_regions); 
draw_circle(list_regions,v); % write circle with the regions listed
fprintf('Drawing circle with %d regions\n',numel(list_regions))
write_names(list_regions,1.2,pi/2);
%end Add_nodes_Callback()