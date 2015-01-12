% --- creates renderings
function drawCircle(v)
    axis square
    delete(allchild(v.hAxes));%
    set(v.hMainFigure,'CurrentAxes',v.hAxes)
    set(0, 'CurrentFigure', v.hMainFigure);  %# for figures
    guidata(v.hMainFigure, v);

    
    appState = getAppStateSub(v);
    
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
        drawing.drawSegment(nextStart,endRadian,sizes(segment),radius,color,[])
        
        pause(0.01)
        hold on        
    end
    
    R=max(sizes(:));
    axis([-2.3*R 2.3*R -2.3*R 2.3*R])
    axis square
    axis off

    drawing.writeLabels(labels, labelRadius, startRadian);

    if isfield(v, 'links')
        links = appState.links;
        drawing.drawLinks(links.edgeMatrix, links.threshold, startRadian, radius);
    end

end

function seq = makeSequentialSub(twoD)
    seq = [twoD(:, 1); flipud(twoD(:, 2))];
end

function appState = getAppStateSub(v)
%[labels, sizes, colors, radius, startRadian, labelRadius, links]

    fields = {'nodeLabels', 'nodeSizes', 'nodeColors', 'links'};
    
    indxs = 1:length(fields);
    setFields = arrayfun(@(i) isfield(v, fields{i}), indxs);
    elemCountPerField = arrayfun(@(i) numel(v.(fields{i})), indxs(setFields));
    if setFields(4)
        elemCountPerField(end) = size(v.links.edgeMatrix, 1);
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
    
    if ~isfield(v,'nodeLabels')
        temp=[(1:numNodes/2)' flipud(((numNodes/2+1):numNodes)')];
        appState.labels=(num2cell(temp));
    else
        appState.labels = v.nodeLabels;
    end
    
    if ~isfield(v, 'radius');
        appState.radius = 1;
    else
        appState.radius = v.radius;
    end
    
    if ~isfield(v, 'nodeSizes')
        appState.sizes(1:numNodes) = appState.radius*1.1;
    else
        appState.sizes=makeSequentialSub(v.nodeSizes) + appState.radius;
    end
    
    if ~isfield(v, 'nodeColors')
        appState.colors=rand(numNodes,1);
        appState.colors(numNodes/2,1)=0.5;% set the mid value as on (to set the color as the mid-value
    else
        appState.colors = makeSequentialSub(v.nodeColors);
    end
    
    if ~isfield(v, 'colorscheme')
        appState.colorscheme=hot;
    else
        appState.colorscheme = v.colorscheme;
    end
    
    if ~isfield(v, 'startRadian')
        appState.startRadian = pi/2;
    else
        appState.startRadian = v.startRadian;
    end
    
    if ~isfield(v, 'labelRadius')
        appState.labelRadius = max(appState.sizes(:)) * 1.1;
    else
        appState.labelRadius = v.labelRadius;
    end
    
    if isfield(v, 'links')
        appState.links.edgeMatrix = v.links.edgeMatrix;
        appState.links.threshold = v.links.threshold;
    end

end