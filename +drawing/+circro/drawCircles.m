% --- creates renderings
function drawCircles(v)
    axis square
    drawing.utils.circro.eraseRenderedObjects(v);
    %delete(allchild(v.hAxes));
    colorbar('off');
    set(v.hMainFigure,'CurrentAxes',v.hAxes)
    set(0, 'CurrentFigure', v.hMainFigure);  %# for figures
    guidata(v.hMainFigure, v);
    
    runFnOnEachCircle(v, @drawCircleSub);
    
    placeNodeColorBarsSub();
    
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
        circleState = utils.circro.getCircleState(circle);
        thisR = max(circleState.outerRadii);
        
        if thisR < circleState.labelRadius && circleState.drawLabels
            thisR = circleState.labelRadius;
        end
        
        if thisR > R
            R = thisR;
        end
    end
    
    runFnOnEachCircle(v, @ifLargerSetR);
    
end

function drawCircleSub(circle)

    
    appState = utils.circro.getCircleState(circle);
    
    labels = appState.labels;
    outerRadii = appState.outerRadii;
    colors = appState.colors;
    nodeColorsColorscheme = appState.nodeColorsColorscheme;
    if isempty(nodeColorsColorscheme)
        nodeColorsColorscheme = hot;
    end
    
    radius = appState.radius;
    startRadian = appState.startRadian;
    labelRadius = appState.labelRadius;

    numNodes=numel(outerRadii);
    fprintf('Drawing circle with %d regions\n',numNodes)

    axis square
    endRadian = startRadian;
    for segment=1:numNodes % draw the circle
        color=utils.valueToColor(colors(segment),colors,nodeColorsColorscheme);
        
        nextStart=endRadian;
        endRadian=nextStart+(2*pi)/numNodes;
        drawing.circro.drawSegment(nextStart,endRadian,radius,outerRadii(segment),color)
        
        pause(0.01)
        hold on        
    end
    
    maxColors = max(colors(:));
    minColors = min(colors(:));
    if maxColors - minColors > eps
        drawing.utils.circro.addColorBar('nodecolors', nodeColorsColorscheme,...
            minColors, maxColors);
    end

    if appState.drawLabels
        drawing.circro.writeLabels(labels, labelRadius, startRadian);
    end

    if isfield(circle, 'edgeMatrix')
        drawing.circro.drawLinks(appState.edgeMatrix, appState.edgeThreshold, startRadian, radius, appState.edgeMatrixColorscheme);
    end

end

function placeNodeColorBarsSub()
    h = gui.getGuiHandle();
    currentColorBars = findall(h.Children, 'Type', 'ColorBar');
    
    nodeColorBars = currentColorBars(arrayfun(...
        @(c) strcmpi(get(c, 'Location'), 'westoutside'), ...
        currentColorBars));
    
    numNodeColorBars = length(nodeColorBars);
    if numNodeColorBars
        c = nodeColorBars(1);
        pos = get(c, 'Position');
        width = pos(3);
        right = 2.3 * width * numNodeColorBars;

        for i = 1:numNodeColorBars
            pos(1) = right * i/numNodeColorBars;
            pos(2) = .1;
            pos(4) = .5;
            c = nodeColorBars(i);
            set(c, 'Position', pos);
        end
    end
    
end