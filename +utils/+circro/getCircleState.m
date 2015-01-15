function circleState = getCircleState(circle)

    fields = {'nodeLabels', 'nodeSizes', 'nodeColors', 'edgeMatrix'};
    
    indxs = 1:length(fields);
    setFields = arrayfun(@(i) isfield(circle, fields{i}), indxs);
    elemCountPerField = arrayfun(@(i) numel(circle.(fields{i})), indxs(setFields));
    if setFields(4)
        elemCountPerField(end) = size(circle.edgeMatrix, 1);
    end
    
    function verifySameElemCountPerField()
        if range(elemCountPerField)
            msg = '';
            for i = 1:setFields
                msg = [msg fields{i} ':' elemCountPerField(i) '  '];
            end
            error('every set field must have same number of elements \n%s', msg);
        end 
    end

    function verifyAtLeastOneFieldSet()
       if ~any(setFields)
        error('can not draw without at least nodeLabels, nodeSizes, nodeColors, or edgeMatrix set');
       end
    end
    
    verifyAtLeastOneFieldSet();
    verifySameElemCountPerField();
    
    numNodes = elemCountPerField(1);
    
    if ~isfield(circle,'nodeLabels')
        temp=[(1:numNodes/2)' flipud(((numNodes/2+1):numNodes)')];
        circleState.labels=(num2cell(temp));
    else
        circleState.labels = circle.nodeLabels;
    end
    
    if ~isfield(circle, 'radius');
        circleState.radius = 1;
    else
        circleState.radius = circle.radius;
    end
    
    if ~isfield(circle, 'nodeSizes')
        circleState.sizes(1:numNodes) = circleState.radius*1.1;
    else
        circleState.sizes=makeSequentialSub(circle.nodeSizes) + circleState.radius;
    end
    
    if ~isfield(circle, 'nodeColors')
        circleState.colors=rand(numNodes,1);
        circleState.colors(numNodes/2,1)=0.5;% set the mid value as on (to set the color as the mid-value
    else
        circleState.colors = makeSequentialSub(circle.nodeColors);
    end
    
    if ~isfield(circle, 'colorscheme')
        circleState.colorscheme=hot;
    else
        circleState.colorscheme = circle.colorscheme;
    end
    
    if ~isfield(circle, 'startRadian')
        circleState.startRadian = pi/2;
    else
        circleState.startRadian = circle.startRadian;
    end
    
    if ~isfield(circle, 'labelRadius')
        circleState.labelRadius = max(circleState.sizes(:)) * 1.1;
    else
        circleState.labelRadius = circle.labelRadius;
    end
    
    if isfield(circle, 'edgeMatrix')
        circleState.edgeMatrix = circle.edgeMatrix;
        if isfield(circle, 'edgeThreshold')
            circleState.edgeThreshold = circle.edgeThreshold;
        else
            circleState.edgeThreshold = .5;
        end
    end

end

function seq = makeSequentialSub(twoD)
    seq = [twoD(:, 1); flipud(twoD(:, 2))];
end
