% --- save screenshot as bitmap image
function SaveBmpMenu_Callback(obj, ~)
v=guidata(obj);
[file,path] = uiputfile('*.png','Save image as');
if isequal(file,0), return; end;
Circro('saveBitmap',[path file]);
%end SaveBmpMenu_Callback()
