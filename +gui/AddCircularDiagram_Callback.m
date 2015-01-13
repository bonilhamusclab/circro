function AddCircularDiagram_Callback(obj, ~)

    fields = {};
    function fn = setFieldFn(field)
        function setterFn(f)
            fields.(field) = f;
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
    
    inputs = cellfun(@emptyOrVal, fileInputs, 'UniformOutput', 0);
    commands.addCircularDiagram(guidata(obj), inputs{:});
    
    if isfield(fields, 'edgeThreshold')
        commands.setCircularEdgeThreshold(guidata(obj), fields.edgeThreshold);
    end
    
    if isfield(fields, 'radius') || isfield(fields, 'labelRadius') || isfield(fields, 'startRadian')
        inputs = {};
        %generate name value pair inputs
        %TODO: clean code w/ less repitition
        for i = 1:length(dimensionInputs)
            field = dimensionInputs{i};
            if isfield(fields, field)
                inputs{end + 1} = field;
                inputs{end + 2} = fields.field;
            end
        end
        commands.setCircularDimensions(inputs{:});
    end
    
end
