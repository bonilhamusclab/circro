function SetEdgeMatrixColorscheme_Callback(obj, ~)
    v=guidata(obj);
    
    if ~isfield(v, 'circles')
        noEdgesToApplyColorSchemeSub();
        return;
    end
    
    availableIndexes = find(cellfun(@(c) isfield(c, 'edgeMatrix'), v.circles));
    
    if isempty(availableIndexes)
        noEdgesToApplyColorSchemeSub();
        return;
    end

    [colorscheme, alpha, circleIndex] = gui.circro.colorschemePrompt(...
        v, 'edge', availableIndexes);

    if ~isempty(colorscheme)
        Circro('circro.setEdgeMatrixColorscheme', colorscheme, alpha, circleIndex);
    end
end

function noEdgesToApplyColorSchemeSub()
    msgbox('No Diagrams available with edges to apply colorscheme');
end