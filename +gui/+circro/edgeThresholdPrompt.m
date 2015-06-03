function f = edgeThresholdPrompt(edges, thresholdSetterFn, defThresh)
    if nargin < 3
        defThresh = .5;
    end


    f = figure('Visible','off', 'Name', 'Set Edge Threshold');
    ax = axes('Units','pixels');
    ax.Position = [74 70 430 320];
    
    function setAndClose(value)
        thresholdSetterFn(value);
        close(f);
    end
    
   
    threshEdit = uicontrol('Style', 'edit', 'String', num2str(defThresh),...
        'Position', [40 20 50 20],...
        'Callback', @(s, ~) thresholdSetterFn(str2double(s.String)));       
    
    uicontrol('Style','text',...
        'Position',[40 40 50 20],...
        'String','Threshold');
    
    uicontrol('Style', 'pushbutton', 'String', 'OK',...
        'Position', [100 20 50 20],...
        'Callback', @(~, ~) setAndClose(str2double(threshEdit.String)));
    
    uicontrol('Style', 'pushbutton', 'String', 'Cancel',...
        'Position', [170 20 50 20],...
        'Callback', @(~, ~) setAndClose(''));
    
    % Make figure visble after adding all components
    f.Visible = 'on';

    if ischar(edges)
        edges = circro.fileUtils.circro.loadMatrix(edges);
    end
    
    upperIndexes = logical(triu(ones(size(edges)), 1));
    normplot(edges(upperIndexes));
end