function SetNodeColors_Callback(obj, ~)
v = guidata(obj);

circleIndex = gui.circro.newOrUpdateCircleIndex(v, 'node colors');
if circleIndex < 0
    return;
end

[colors_filename, colors_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    'Select an excel file');
    if isequal(colors_filename,0), return; end;
    
colorscheme = '';
setColorscheme = questdlg('Set Color Scheme For Node Colors?');
if strcmpi(setColorscheme, 'yes')
    colorscheme = gui.circro.colorschemePrompt(guidata(obj), 'Node Colors', '', circleIndex);
end
    
Circro('circro.setNodeColors', [colors_pathname colors_filename], circleIndex, colorscheme);
end