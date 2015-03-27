function addColorBar(type, colorscheme, minColors, maxColors)

position.edgematrix = @placeEdgeMatrixColorBarSub;
position.nodecolors = @placeNodeColorBarSub;

validTypes = {'edgematrix', 'nodecolors'};
type = validatestring(lower(type), validTypes);

curr = gca;

placeColorBar = position.(type);
ax = axes;
c = placeColorBar(ax);

caxis([minColors, maxColors]);
colormap(c, colorscheme);
set(ax, 'Visible', 'off');

axes(curr);

end

function c = placeEdgeMatrixColorBarSub(ax)
    c = colorbar(ax);
    set(c, 'Location', 'eastoutside');
    pos = get(c, 'Position');
    pos(2) = .1;
    pos(4) = .5;
    set(c, 'Position', pos);
end

function c = placeNodeColorBarSub(ax)
    
    c = colorbar(ax);
    set(c, 'Location', 'westoutside');
    
end