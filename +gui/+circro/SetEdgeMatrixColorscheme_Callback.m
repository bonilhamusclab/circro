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

    circleIndex = gui.circro.promptCircleIndex(v, 'Colors Scheme', availableIndexes);

    colorscheme = getColorSchemePromptSub();

    if ~isempty(colorscheme)
        Circro('circro.setEdgeMatrixColorscheme', colorscheme, circleIndex);
    end
end

function colorscheme = getColorSchemePromptSub()
    options = utils.colorMapNames();
    optionsStr = options{end};
    for i = (length(options) - 1): -1: 1
        optionsStr = [options{i} ', ' optionsStr];
    end
    prompt = {sprintf('Enter Colorscheme (%s)', optionsStr)};
    name = 'Colorscheme options for Edge Matrix';
    answer = inputdlg(prompt, name);
    
    colorscheme = answer{1};
end

function noEdgesToApplyColorSchemeSub()
    msgbox('No Diagrams available with edges to apply colorscheme');
end