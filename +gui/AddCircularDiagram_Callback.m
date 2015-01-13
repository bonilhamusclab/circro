function AddCircularDiagram_Callback(obj, ~)

    fields = {};
    function fn = setFieldFn(field)
        function setterFn(f)
            fields.(field) = f;
            %empty signifies to ignore value
            if isempty(f)
                fields = rmfield(fields, field);
            end
        end
        fn = @setterFn;
    end

    fileInputs = {'labels', 'sizes', 'edgeMatrix', 'colors'};
    
    fns.setLabelsFn = setFieldFn('labels');
    fns.setSizesFn = setFieldFn('sizes');
    fns.setEdgeMatrixFn = setFieldFn('edgeMatrix');
    fns.setColorsFn = setFieldFn('colors');
    
    fns.setEdgeThresholdFn = setFieldFn('edgeThreshold');
    fns.setRadiusFn = setFieldFn('radius');
    fns.setLabelRadiusFn = setFieldFn('labelRadius');
    fns.setStartRadianFn = setFieldFn('startRadian');
    
    dimensionInputs = {'radius', 'labelRadius', 'startRadian'};
    
    h = gui.circularDiagram.filesSelection(fns);
    waitfor(h);
    
    function ret = emptyOrVal(field)
        if ~isfield(fields, field)
            ret = '';
        else
            ret = fields.(field);
        end
    end
    
    
    if any(cellfun(@(f) isfield(fields, f), fileInputs))
        inputs = cellfun(@emptyOrVal, fileInputs, 'UniformOutput', 0);
        commands.addCircularDiagram(guidata(obj), inputs{:});
    end
    
    if isfield(fields, 'edgeThreshold')
        commands.setCircularEdgeThreshold(guidata(obj), fields.edgeThreshold);
    end
    
    if any(cellfun(@(f) isfield(fields, f), dimensionInputs))
        inputs = {};
        %generate name value pair inputs
        %TODO: clean code w/ less repitition
        for i = 1:length(dimensionInputs)
            field = dimensionInputs{i};
            if isfield(fields, field)
                inputs{end + 1} = field;
                inputs{end + 1} = fields.(field);
            end
        end
        commands.setCircularDimensions(guidata(obj), inputs{:});
    end
    
end
