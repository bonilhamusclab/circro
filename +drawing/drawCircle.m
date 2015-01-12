% --- creates renderings
function drawCircle(v)
    axis square
    delete(allchild(v.hAxes));%
    set(v.hMainFigure,'CurrentAxes',v.hAxes)
    set(0, 'CurrentFigure', v.hMainFigure);  %# for figures

    if ~isfield(v, 'labels')
        error('labels must be added to draw a circle, see commands.setCircularNodeLabels or commands.addCircularDiagram')
    end
    labels = v.labels;

    fprintf('Drawing circle with %d regions\n',numel(labels))
    numNodes=numel(labels);
    innerR = 1;
    
    if ~isfield(v, 'nodeSizes')
        nodeSizes(1:numNodes) = innerR*1.1;
    else
        nodeSizes=makeSequential(v.nodeSizes) + innerR;
    end
    if isfield(v, 'nodeColors')
        nodeColors = makeSequential(v.nodeColors);
    else
        nodeColors=rand(numNodes,1);
        nodeColors(numNodes/2,1)=0.5;% set the mid value as on (to set the color as the mid-value
    end
    if ~isfield(v, 'colorscheme')
        v.colorscheme=hot;
    end

    startRadian=pi/2; %sets the origin of the first segment (could also be 0)
    endRadian=startRadian+(2*pi)/numNodes; %sets the end of the first segment (could also be pi/2)

    guidata(v.hMainFigure, v);

    axis square        
    for segment=1:numNodes % draw the circle
        % map colors
        color=utils.findColorInColorscheme(nodeColors(segment),nodeColors,v.colorscheme);           
        drawing.drawSegment(startRadian,endRadian,nodeSizes(segment),innerR,color,[])
        startRadian=endRadian;
        endRadian=startRadian+(2*pi)/numNodes;
        pause(0.01)
        hold on        
    end
    R=max(nodeSizes(:));
    axis([-2.3*R 2.3*R -2.3*R 2.3*R])
    axis square
    axis off

    radius = 1.2;
    startRadian = pi/2;
    drawing.writeLabels(v, radius, startRadian);

    if isfield(v, 'links')
        drawing.drawLinks(v)
    end

end

function seq = makeSequential(twoD)
    seq = [twoD(:, 1); flipud(twoD(:, 2))];
end