function SetDimensions_Callback(obj, ~)
v=guidata(obj);

circlesIndex = utils.circro.maxCirclesIndex(v);


prompt = {'Radius:', 'Label Radius:', 'Start Radian:', 'Circles Index:'};
defaults = {'1','1.2', num2str(pi/2), num2str(circlesIndex)};

dlg_title = 'Dimension Options';
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines,defaults);

if ~isempty(answer)
    radius = str2double(answer(1));
    labelRadius = str2double(answer(2));
    startRadian = str2double(answer(3));
    circlesIndex = str2double(answer(4));
    Circro('circro.setDimensions', radius, labelRadius, startRadian, circlesIndex);
end