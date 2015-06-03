function [colorscheme, alpha, circleIndex] = colorSettingsPrompt(v, type, availableIndexes, circleIndex)
    if nargin < 4
        circleIndex = gui.circro.promptCircleIndex(v, 'Colors Scheme', availableIndexes);
        if circleIndex < 0
            colorscheme = '';
            alpha = '';
            return;
        end
    end
    
    if strcmpi(type, 'nodes')
        msg = 'Node Color Settings';
    else
        msg = 'Edge Color Settings';
    end
    
    if circleIndex > circro.utils.circro.maxCircleIndex(v)
        circleState = circro.utils.circro.getCircleState();
    else
        circleState = circro.utils.circro.getCircleState(v.circles{circleIndex});
    end
    
    colorscheme = circleState.([type 'Colorscheme']);
    alpha = circleState.([type 'Alpha']);
    
    
    options = circro.utils.colorMapNames();
    optionsStr = options{end};
    for i = (length(options) - 1): -1: 1
        optionsStr = [options{i} ', ' optionsStr];
    end
    prompt = {sprintf('Colorscheme (%s)', optionsStr), ...
        'Alpha (0 - 1)'};
    name = sprintf('Color Settings for %s', msg);
    answer = inputdlg(prompt, name, 2, {colorscheme, num2str(alpha)});
    
    if ~isempty(answer)
        colorscheme = answer{1};
        alpha = str2double(answer{2});
    else
        colorscheme = '';
    end
end
