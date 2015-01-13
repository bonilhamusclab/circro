function SetCircularDimensions_Callback(obj, ~)
v=guidata(obj);

prompt = {'Radius:', 'Label Radius:', 'Start Radian:'};
dlg_title = 'Dimension Options';
defaults = {'1','1.2', num2str(pi/2)};
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines,defaults);
radius = str2double(answer(1));
labelRadius = str2double(answer(2));
startRadian = str2double(answer(3));
commands.setCircularDimensions(v, radius, labelRadius, startRadian);
