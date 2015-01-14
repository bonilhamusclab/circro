function SetDimensions_Callback(obj, ~)
v=guidata(obj);

if ~isfield(v, 'circles')
    noDimensionsToSetPopUpSub();
    return;
end

if isempty(v.circles)
    noDimensionsToSetPopUpSub();
    return;
end

circleIndex = gui.circro.promptCircleIndex(v, 'dimensions');
if circleIndex < 1
    return;
end


prompt = {'Radius:', 'Label Radius:', 'Start Radian:'};
defaults = {'1','1.2', num2str(pi/2)};

dlg_title = 'Dimension Options';
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines,defaults);

if ~isempty(answer)
    radius = str2double(answer(1));
    labelRadius = str2double(answer(2));
    startRadian = str2double(answer(3));
    Circro('circro.setDimensions', radius, labelRadius, startRadian, circleIndex);
end
end

function noDimensionsToSetPopUpSub()
    msgbox('No Diagrams available with dimensions to set');
end