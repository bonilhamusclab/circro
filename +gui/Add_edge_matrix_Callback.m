function Add_edge_matrix_Callback(obj, ~)
v=guidata(obj);

[matrix_filename, matrix_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    'Select an excel file');
if isequal(matrix_filename,0), return; end;
prompt = {'Threshold:','Start Radian:', 'Line Radius:'};
dlg_title = 'Matrix Options';
num_lines = 1;
def = {'.5','0', '1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
threshold = str2double(answer(1));
start_radian = str2double(answer(2));
radius = str2double(answer(3));
commands.addEdgeMatrix(v, [matrix_pathname matrix_filename], threshold, start_radian, radius);
