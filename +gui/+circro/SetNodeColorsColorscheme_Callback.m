function SetNodeColorsColorscheme_Callback(obj, ~)
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

    circleIndex = gui.circro.promptCircleIndex(v, 'Colors Scheme', availableIndexes);

    colorscheme = getColorSchemePromptSub();

    if ~isempty(colorscheme)
        Circro('circro.setNodeColorsColorscheme', colorscheme, circleIndex);
    end
end

function colorscheme = getColorSchemePromptSub()
    options = utils.colorMapNames();
    optionsStr = options{end};
    for i = (length(options) - 1): -1: 1
        optionsStr = [options{i} ', ' optionsStr];
    end
    prompt = {sprintf('Enter Colorscheme (%s)', optionsStr)};
    name = 'Colorscheme options for Node Colors';
    answer = inputdlg(prompt, name);
    
    colorscheme = answer{1};
end

function noNodeColorsToApplyColorSchemeSub()
    msgbox('No Diagrams available with node colors to apply colorscheme');
end