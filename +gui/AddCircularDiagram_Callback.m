function AddCircularDiagram_Callback(obj, ~)

    files = {};
    function fn = setFile(field)
        function setterFn(f)
            files.(field) = f;
        end
        fn = @setterFn;
    end

    neededFiles = {'labels', 'sizes', 'edgeMatrix', 'colors'};
    
    setFileFns = cellfun(@setFile, neededFiles, 'UniformOutput', 0);
    h = gui.circularDiagram.filesSelection(setFileFns{:});
    waitfor(h);
    
    function ret = emptyOrVal(field)
        if ~isfield(files, field)
            ret = '';
        else
            ret = files.(field);
        end
    end
    
    inputs = cellfun(@emptyOrVal, neededFiles, 'UniformOutput', 0);
    commands.addCircularDiagram(guidata(obj), inputs{:});
end