function [v, status] = addColorschemeIfCustom(v, colorscheme)
    names = v.colorMapNames;
    isName = any(cellfun(@(s) strcmpi(s, colorscheme), names));
    
    if isName
        status = 'isName';
    else
        q = sprintf('%s is not a default, do you still wish to use it?', colorscheme);
        answer = questdlg(q, 'Colorscheme', 'yes', 'no', 'yes');
        if strcmpi(answer, 'yes')
            Circro('circro.addColorschemes', colorscheme);
            status = 'added';
            v = guidata(v.hMainFigure);
        else
            status = 'cancelled';
        end
    end
end