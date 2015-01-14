function SetNodeColors_Callback(obj, ~)
v = guidata(obj);

if ~isfield(v, 'circles') || isempty(v.circles)
    yes = createNewDiagramQuestSub();
    if ~yes
        return;
    end
end

circleIndex = gui.circro.promptCircleIndex(v, 'node colors');
if circleIndex < 1
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

function yes = createNewDiagramQuestSub()
    question = 'No Diagrams available to set colors to, render node colors as new Diagram?';
    title = 'Create New Diagram';
    yes = strcmpi(questdlg(question, title), 'yes');
end
