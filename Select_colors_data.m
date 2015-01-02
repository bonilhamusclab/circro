function Select_colors_data(v)
[colors_filename, colors_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    'Select a text file');
    if isequal(colors_filename,0), return; end;
    [value_colors, ~]=xlsread([colors_pathname colors_filename]);
    v.value_colors=value_colors;     
    guidata(v.hMainFigure,v)
% end select colors data