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
        Circro('circro.setEdgeMatrix', matrixFullPath, threshold, circleIndex);
    end
end