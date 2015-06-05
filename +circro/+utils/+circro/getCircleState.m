function circleState = getCircleState(circle)
%function circleState = getCircleState(circle)
%if no inputs returns default state, else returns state for the circle

    circleInput = nargin > 0;
    if ~circleInput
        circle = {};
    end

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
    
    if circleInput
        verifyAtLeastOneFieldSet();
        verifySameElemCountPerField();
        numNodes = elemCountPerField(1);
    else
        numNodes = 0;
    end
    
    if ~isfield(circle,'nodeLabels')
        temp= [(1:numNodes/2)' ((numNodes/2+1):numNodes)'];
        circleState.labels=(num2cell(temp));
    else
        circleState.labels = circle.nodeLabels;
    end
    
    circleState.drawLabels = ~isfield(circle, 'showLabels') || circle.showLabels;
    
    if ~isfield(circle, 'radius');
        circleState.radius = 1;
    else
        circleState.radius = circle.radius;
    end
    
    if ~isfield(circle, 'nodeSizes')
        circleState.outerRadii(1:numNodes) = circleState.radius*1.1;
    else
        circleState.outerRadii = makeSequentialSub(circle.nodeSizes) + circleState.radius;
    end
    
    if ~isfield(circle, 'nodeColors')
        circleState.colors=repmat(.5, numNodes, 1);
    else
        circleState.colors = makeSequentialSub(circle.nodeColors);
    end
    
    if ~isfield(circle, 'nodeColorscheme')
        circleState.nodeColorscheme = 'hot';
    else
        circleState.nodeColorscheme = circle.nodeColorscheme;
    end
    
    if ~isfield(circle, 'nodeAlpha')
        circleState.nodeAlpha = .4;
    else
        circleState.nodeAlpha = circle.nodeAlpha;
    end
    
    if ~isfield(circle, 'startRadian')
        circleState.startRadian = pi/2;
    else
        circleState.startRadian = circle.startRadian;
    end
    
    if ~isfield(circle, 'labelRadius')
        circleState.labelRadius = max(circleState.outerRadii(:)) * 1.01;
    else
        circleState.labelRadius = circle.labelRadius;
    end
    
    if isfield(circle, 'edgeMatrix')
        circleState.edgeMatrix = circle.edgeMatrix;
    end
    if isfield(circle, 'edgeThreshold')
        circleState.edgeThreshold = circle.edgeThreshold;
    else
        circleState.edgeThreshold = .5;
    end
    if isfield(circle, 'edgeColorscheme')
        circleState.edgeColorscheme = circle.edgeColorscheme;
    else
        circleState.edgeColorscheme = 'jet';
    end
    if isfield(circle, 'edgeAlpha')
        circleState.edgeAlpha = circle.edgeAlpha;
    else
        circleState.edgeAlpha = .7;
    end

end

function seq = makeSequentialSub(twoD)
    seq = [twoD(:, 1); flipud(twoD(:, 2))];
end
