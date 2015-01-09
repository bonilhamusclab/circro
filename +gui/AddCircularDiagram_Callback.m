% Callback functions
% --- add a circle with default options
function AddCircularDiagram_Callback(obj, ~)
%{
[list_filename, list_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    'Select an excel file');
if isequal(list_filename,0), return; end;
%}
h = gui.circularDiagram.filesSelection;
waitfor(h);
commands.addCircularDiagram(guidata(obj), h.labelsFile);