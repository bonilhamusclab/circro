function SetEdgeMatrix_Callback(obj, ~)
v=guidata(obj);

circleIndex = gui.circro.newOrUpdateCircleIndex(v, 'node sizes');
if circleIndex < 0
    return;
end

[matrix_filename, matrix_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    'Select an excel file');
if isequal(matrix_filename,0), return; end;
prompt = {'Threshold:'};
dlg_title = 'Matrix Options';
num_lines = 1;
def = {'.5'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
threshold = str2double(answer(1));

Circro('circro.setEdgeMatrix', [matrix_pathname matrix_filename], threshold, circleIndex);
