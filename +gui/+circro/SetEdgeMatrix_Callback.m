function SetEdgeMatrix_Callback(obj, ~)
    v=guidata(obj);

    circleIndex = gui.circro.newOrUpdateCircleIndex(v, 'node sizes');
    if circleIndex < 0
        return;
    end

    [matrixFilename, matrixPathname] = uigetfile( ...
                        {'*.xlsx;', 'excel files (*.xlsx)';...
                        '*.xls;', 'excel files (*.xls)'; ...
                        '*.*',       'All Files (*.*)'},...
                        'Select an excel file');
    if isequal(matrixFilename,0), return; end;

    matrixFullPath = [matrixPathname matrixFilename];

    threshold = '';
    function setEdgeThreshold(value)
        threshold = value;
    end

    f = gui.circro.edgeThresholdPrompt(matrixFullPath, @setEdgeThreshold);
    uiwait(f);

    if ~isempty(threshold)
        colorscheme = '';
        setColorscheme = questdlg('Set Color Scheme For Edge Weights?');
        if strcmpi(setColorscheme, 'yes')
            [colorscheme, alpha] = gui.circro.colorschemePrompt(guidata(obj), 'edge', '', circleIndex);
            Circro('circro.setEdgeMatrix', matrixFullPath, threshold, colorscheme, alpha, circleIndex);
        else
            Circro('circro.setEdgeMatrix', matrixFullPath, threshold, 'circleIndex', circleIndex);
        end
    end
end
