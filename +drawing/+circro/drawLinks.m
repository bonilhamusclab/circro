function drawLinks(edgeMatrix, threshold, startRadian, radius, colorscheme)

    links=triu(edgeMatrix>threshold);%# this is a random list of connections
    [startNodes,stopNodes]=ind2sub(size(links),find(links(:)));
    
    numberNodes=size(edgeMatrix,1);
    anglePerNode = 2 * pi/numberNodes;
    
    %must be declared before drawLink is invoked
    function theta = nodeTheta(node)
        theta = startRadian + node * anglePerNode - anglePerNode/2;
    end

    if nargin < 5
        colorscheme = '';
    end
    %must be declared before drawLink is invoked
    function color = getColor(weight)
        if ~isempty(colorscheme)
            color = utils.valueToColor(weight, edgeMatrix(links), colorscheme);
        else
            color = [.5 .5 .5];
        end
    end
    
    for i=1:size(startNodes,1)
        startNode = startNodes(i);
        stopNode = stopNodes(i);
        
        if startNode~=stopNode
            drawLink(startNode, stopNode);
            %pause(0.8)
        end

    end
    
    if ~isempty(colorscheme)
        minWeight = min(edgeMatrix(links));
        maxWeight = max(edgeMatrix(links));
        c = colorbar;
        pos = get(c, 'Position');
        pos(2) = .1;
        pos(4) = .5;
        set(c, 'Position', pos);
        caxis([minWeight, maxWeight]);
        colormap(c, colorscheme);        
    end
    
    function drawLink(startNode, stopNode)
        thetaStart = nodeTheta(startNode);
        thetaStop = nodeTheta(stopNode);

        xStart = radius * cos(thetaStart);
        yStart = radius * sin(thetaStart);

        xStop = radius * cos(thetaStop);
        yStop = radius * sin(thetaStop);

        distance= norm([xStart yStart] - [xStop yStop]);

        %occurs with links connecting opposite nodes of circle
        if distance >= 2*radius
            elevation=radius/2;
        else
            elevation=radius-(distance/2);
        end

        interTheta = (thetaStart + thetaStop)/2;
        if abs(thetaStart - thetaStop) >= pi
            interTheta = interTheta - pi;
        end

        xInter = elevation * cos(interTheta);
        yInter = elevation * sin(interTheta);

        xs = [xStart xInter xStop];
        ys = [yStart yInter yStop]; 

        pp = spline(pi * [0:2], [xs; ys]);
        pts = ppval(pp, linspace(0, 2*pi, 100));

        weight = edgeMatrix(startNode,stopNode);
        color = getColor(weight);
        plot(pts(1,:), pts(2,:), 'color', color, 'linewidth', weight);
    end
    
end