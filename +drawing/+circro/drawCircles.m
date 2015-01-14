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
        circleState = utils.circro.getCircleState(circle);
        if circleState.labelRadius > R
            R = circleState.labelRadius;
        end
    end
    
    runFnOnEachCircle(v, @ifLargerSetR);
    
end

function drawCircleSub(circle)

    
    appState = utils.circro.getCircleState(circle);
    
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