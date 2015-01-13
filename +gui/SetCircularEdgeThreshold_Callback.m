function SetCircularEdgeThreshold_Callback(obj, ~)
v=guidata(obj);

prompt = {'Edge Threshold:'};
dlg_title = 'Edge Threshold Options';
defaults = {num2str(.5)};
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines,defaults);
edgeThreshold = str2double(answer(1));
commands.circro.setEdgeThreshold(v, edgeThreshold);
