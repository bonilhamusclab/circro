function closeDiagrams(v)
    if isfield(v, 'circles')
        v = rmfield(v, 'circles');
    end
    guidata(v.hMainFigure,v);
    circro.drawing.circro.drawCircles(v);
end