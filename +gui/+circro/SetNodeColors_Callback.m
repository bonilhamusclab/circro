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
setColorscheme = questdlg('Set Color Settings For Nodes?');
if strcmpi(setColorscheme, 'yes')
    [colorscheme, alpha, circleIndex] = gui.circro.colorSettingsPrompt(guidata(obj), 'node', '', circleIndex);
    Circro('circro.setNodeColors', [colors_pathname colors_filename], colorscheme, alpha, circleIndex);
else
    Circro('circro.setNodeColors', [colors_pathname colors_filename], 'circleIndex', circleIndex);
end

end
