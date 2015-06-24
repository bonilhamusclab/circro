function addColorMapName(v, newName)
    names = v.colorMapNames;
    names{end + 1} = newName;
    v.colorMapNames = names;
    guidata(v.hMainFigure, v);