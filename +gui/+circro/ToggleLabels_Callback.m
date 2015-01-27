function ToggleLabels_Callback(obj, ~)
v=guidata(obj);

circleIndex = gui.circro.promptCircleIndex(v, 'Toggle Labels');

if circleIndex < 1
    msgbox('No circles are rendered yet');
    return;
end

Circro('circro.toggleLabels', circleIndex);

end
