function EditNodeColorSettings_Callback(obj, ~)
    v=guidata(obj);
    
    if ~isfield(v, 'circles')
        noNodeColorsToApplyColorSchemeSub();
        return;
    end
    
    availableIndexes = find(cellfun(@(c) isfield(c, 'nodeColors'), v.circles));
    
    if isempty(availableIndexes)
        noNodeColorsToApplyColorSchemeSub();
        return;
    end

    [colorscheme, circleIndex] = gui.circro.colorschemePrompt(...
        v, 'Node Colors', availableIndexes);

    if ~isempty(colorscheme)
        Circro('circro.editNodeColorSettings', colorscheme, circleIndex);
    end
end

function noNodeColorsToApplyColorSchemeSub()
    msgbox('No Diagrams available with node colors to apply colorscheme');
end
