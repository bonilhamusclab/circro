function AddDiagram_Callback(~, ~)

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

    fns.setLabelsFn = setFieldFn('labels');
    fns.setSizesFn = setFieldFn('sizes');
    fns.setEdgeMatrixFn = setFieldFn('edgeMatrix');
    fns.setColorsFn = setFieldFn('colors');
    
    fns.setEdgeThresholdFn = setFieldFn('edgeThreshold');
    fns.setRadiusFn = setFieldFn('radius');
    fns.setLabelRadiusFn = setFieldFn('labelRadius');
    fns.setStartRadianFn = setFieldFn('startRadian');
    
    fns.setEdgeColorschemeFn = setFieldFn('edgeColorscheme');
    fns.setEdgeAlphaFn = setFieldFn('edgeAlpha');

    fns.setNodeColorschemeFn = setFieldFn('nodeColorscheme');
	fns.setNodeAlphaFn = setFieldFn('nodeAlpha');
    
    h = gui.circro.addDiagram.optionsSelection(fns);
    waitfor(h);
    

	cmdMap.setNodeLabels.required = {'labels'};
	cmdMap.setNodeSizes.required = {'sizes'};
	cmdMap.setNodeColors.required = {'colors'};
	cmdMap.setEdgeMatrix.required = {'edgeMatrix'};
	cmdMap.setEdgeThreshold.required = {'edgeThreshold'};
	cmdMap.setDimensions.named = {'radius', 'labelRadius', 'startRadian'};
	cmdMap.editEdgeColorSettings.named = {'edgeColorscheme', 'edgeAlpha'};
	cmdMap.editNodeColorSettings.named = {'nodeColorscheme', 'nodeAlpha'};
    
    function val = safeGet(f, default)
        if nargin < 2
            default = {};
        end
        
        if isfield(fields, f)
            val = fields.(f);
        else
            val = default;
        end
    end

	function inputs = getInputs(cmd)
        required = {};
        if isfield(cmdMap.(cmd), 'required')
            requiredParams = cmdMap.(cmd).required;
            setIndxs = cellfun(@(p) ~isempty(safeGet(p)), requiredParams);
            required = cellfun(@(p) fields.(p), requiredParams(setIndxs), 'UniformOutput', 0);
            if isempty(required)
                inputs = {};
                return;
            end
        end
   
        named = {};
        function updateNamed(f)
            v = fields.(f);
            named = [named {f, v}];
        end
        if isfield(cmdMap.(cmd), 'named')
            namedParams = cmdMap.(cmd).named;
            setNamedIndxs = cellfun(@(p) ~isempty(safeGet(p)), namedParams);
            cellfun(@updateNamed, namedParams(setNamedIndxs), 'UniformOutput', 0);
        end
		inputs = [required, named];
	end

	function runIfSet(cmd)
		inputs = getInputs(cmd);
		if ~isempty(inputs)
			Circro(['circro.' cmd], inputs{:});
		end
	end

	cellfun(@(c) runIfSet(c), fieldnames(cmdMap), 'UniformOutput', 0);

end
