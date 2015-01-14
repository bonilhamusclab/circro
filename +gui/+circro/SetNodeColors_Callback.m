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
    
Circro('circro.setNodeColors', [colors_pathname colors_filename], circleIndex);
end

function createNew = createNewOrUpdateQuestSub()
    question = 'Render node colors as new diagram or update current diagram?';
    title = 'Create New Or Update';
    answer = questdlg(question, title, 'New', 'Update', 'Update');
    createNew = strcmpi(answer, 'new');
    if strcmpi(answer, 'cancel')
        createNew = -1;
    end
end
