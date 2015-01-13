% --- creates renderings
function drawCircles(v)
    axis square
    delete(allchild(v.hAxes));
    set(v.hMainFigure,'CurrentAxes',v.hAxes)
    set(0, 'CurrentFigure', v.hMainFigure);  %# for figures
    guidata(v.hMainFigure, v);
    
    runFnOnEachCircle(v, @drawCircleSub);
    
    R=getMaxRadiusSub(v, 1.2);
    axis([-1.3*R 1.3*R -1.3*R 1.3*R])
    axis square
    axis off
end

function runFnOnEachCircle(v, fn)
    if isfield(v, 'circles')
        numCircles = length(v.circles);
        for i = 1:numCircles
            fn(v.circles{i});
        end
    end
end

function R = getMaxRadiusSub(v, minR)
    R = minR;
    
    function ifLargerSetR(circle)
        circleState = getCircleStateSub(circle);
        if circleState.labelRadius > R
            R = circleState.labelRadius;
        end
    end
    
    runFnOnEachCircle(v, @ifLargerSetR);
    
end

function drawCircleSub(circle)

    
    appState = getCircleStateSub(circle);
    
    labels = appState.labels;
    sizes = appState.sizes;
    colors = appState.colors;
    colorscheme = appState.colorscheme;
    radius = appState.radius;
    startRadian = appState.startRadian;
    labelRadius = appState.labelRadius;

    numNodes=numel(labels);
    fprintf('Drawing circle with %d regions\n',numNodes)

    axis square
    endRadian = startRadian;
    for segment=1:numNodes % draw the circle
        color=utils.findColorInColorscheme(colors(segment),colors,colorscheme);
        
        nextStart=endRadian;
        endRadian=nextStart+(2*pi)/numNodes;
        drawing.circro.drawSegment(nextStart,endRadian,sizes(segment),radius,color,[])
        
        pause(0.01)
        hold on        
    end

    drawing.circro.writeLabels(labels, labelRadius, startRadian);

    if isfield(circle, 'edgeMatrix')
        drawing.circro.drawLinks(appState.edgeMatrix, appState.edgeThreshold, startRadian, radius);
    end

end

function seq = makeSequentialSub(twoD)
    seq = [twoD(:, 1); flipud(twoD(:, 2))];
end

function appState = getCircleStateSub(circle)
%[labels, sizes, colors, radius, startRadian, labelRadius, links]

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
        error('can not draw without at least nodeLabels, nodeSizes, or nodeColors set');
       end
    end
    
    verifyAtLeastOneFieldSet();
    verifySameElemCountPerField();
    
    numNodes = elemCountPerField(1);
    
    if ~isfield(circle,'nodeLabels')
        temp=[(1:numNodes/2)' flipud(((numNodes/2+1):numNodes)')];
        appState.labels=(num2cell(temp));
    else
        appState.labels = circle.nodeLabels;
    end
    
    if ~isfield(circle, 'radius');
        appState.radius = 1;
    else
        appState.radius = circle.radius;
    end
    
    if ~isfield(circle, 'nodeSizes')
        appState.sizes(1:numNodes) = appState.radius*1.1;
    else
        appState.sizes=makeSequentialSub(circle.nodeSizes) + appState.radius;
    end
    
    if ~isfield(circle, 'nodeColors')
        appState.colors=rand(numNodes,1);
        appState.colors(numNodes/2,1)=0.5;% set the mid value as on (to set the color as the mid-value
    else
        appState.colors = makeSequentialSub(circle.nodeColors);
    end
    
    if ~isfield(circle, 'colorscheme')
        appState.colorscheme=hot;
    else
        appState.colorscheme = circle.colorscheme;
    end
    
    if ~isfield(circle, 'startRadian')
        appState.startRadian = pi/2;
    else
        appState.startRadian = circle.startRadian;
    end
    
    if ~isfield(circle, 'labelRadius')
        appState.labelRadius = max(appState.sizes(:)) * 1.1;
    else
        appState.labelRadius = circle.labelRadius;
    end
    
    if isfield(circle, 'edgeMatrix')
        appState.edgeMatrix = circle.edgeMatrix;
        appState.edgeThreshold = circle.edgeThreshold;
    end

end