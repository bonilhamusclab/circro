function SetEdgeThreshold_Callback(obj, ~)
v=guidata(obj);

if ~isfield(v, 'circles')
    noEdgesToThresholdPopUpSub();
    return;
end

availableIndexes = find(cellfun(@(c) isfield(c, 'edgeMatrix'), v.circles));

if isempty(availableIndexes)
    noEdgesToThresholdPopUpSub()
    return;
end


circleIndex = gui.circro.promptCircleIndex(v, 'edge threshold', availableIndexes);
if circleIndex < 1
    return;
end

prompt = {'Edge Threshold:'};
dlg_title = 'Edge Threshold Options';
defaults = {num2str(.5)};
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines,defaults);

if ~isempty(answer)
    edgeThreshold = str2double(answer(1));
    Circro('circro.setEdgeThreshold', edgeThreshold, circleIndex);
end
end

function noEdgesToThresholdPopUpSub()
    msgbox('No Diagrams available with edges to threshold');
end