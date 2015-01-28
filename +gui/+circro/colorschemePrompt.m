function [colorscheme, circleIndex] = colorschemePrompt(v, msg, availableIndexes)
    circleIndex = gui.circro.promptCircleIndex(v, 'Colors Scheme', availableIndexes);
    if circleIndex < 0
        colorscheme = '';
        return;
    end
    
    options = utils.colorMapNames();
    optionsStr = options{end};
    for i = (length(options) - 1): -1: 1
        optionsStr = [options{i} ', ' optionsStr];
    end
    prompt = {sprintf('Enter Colorscheme (%s)', optionsStr)};
    name = sprintf('Colorscheme options for %s', msg);
    answer = inputdlg(prompt, name);
    
    if ~isempty(answer)
        colorscheme = answer{1};
    else
        colorscheme = '';
    end
end