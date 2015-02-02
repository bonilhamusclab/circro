function addColorBar(type, colorscheme, minColors, maxColors)

position.edgematrix = @setEdgeMatrixColorBarPosition;
position.nodecolors = @setNodeColorBarPosition;
    
c = colorbar;

validTypes = {'edgematrix', 'nodecolors'};
type = validatestring(lower(type), validTypes);

setPos = position.(type);
setPos(c);

caxis([minColors, maxColors]);
colormap(c, colorscheme);

end

function setEdgeMatrixColorBarPosition(c)
    set(c, 'Location', 'eastoutside');
    pos = get(c, 'Position');
    pos(2) = .1;
    pos(4) = .5;
    set(c, 'Position', pos);
end

function setNodeColorBarPosition(c)
    location = 'westoutside';
    h = gui.getGuiHandle();
    currentColorBars = findall(h.Children, 'Type', 'ColorBar');
    if ~isempty(currentColorBars)
        nodeColorBarCount = sum(...
            arrayfun(@(c) ~strcmpi(get(c, 'Location'), 'eastoutside'), ...
            currentColorBars));
        if nodeColorBarCount > 3
            warning('Will Overwrite Current Node Colorbar plot, can currently only support 3');
        end
        nodeColorBarCount = mod(nodeColorBarCount, 3);
        if nodeColorBarCount == 1
            location = 'northoutside';
        elseif nodeColorBarCount == 2
            location = 'southoutside';
        end
    end
    set(c, 'Location', location);
    pos = get(c, 'Position');
    if strcmpi(location, 'westoutside')
        pos(2) = .1;
        pos(4) = .5;
    else
        pos(3) = .5;
    end
    set(c, 'Position', pos);
end