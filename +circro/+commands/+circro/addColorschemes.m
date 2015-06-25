function addColorschemes(v, newNames)
    [head, tail] = headAndTailSub(newNames);
    if isempty(head)
        return;
    end
    
    names = v.colorMapNames;
    names{end + 1} = head;
    v.colorMapNames = names;
    guidata(v.hMainFigure, v);
    
    if ~isempty(tail)
        circro.commands.circro.addColorschemes(v, tail);
    end
end

function [head, tail] = headAndTailSub(newNames)
    if ischar(newNames)
        head = newNames;
        tail = {};
    elseif isempty(newNames)
        head = '';
        tail = {};
    elseif length(newNames) == 1
        head = newNames{1};
        tail = {};
    else
        head = newNames{1};
        tail = newNames(2: end);
    end
end