function addColorBar(type, colorscheme, minColors, maxColors)

position.edgematrix = @placeEdgeMatrixColorBarSub;
position.nodecolors = @placeNodeColorBarSub;

validTypes = {'edgematrix', 'nodecolors'};
type = validatestring(lower(type), validTypes);

placeColorBar = position.(type);
c = placeColorBar();

caxis([minColors, maxColors]);
colormap(c, colorscheme);

end

function c = placeEdgeMatrixColorBarSub()
    c = colorbar;
    set(c, 'Location', 'eastoutside');
    pos = get(c, 'Position');
    pos(2) = .1;
    pos(4) = .5;
    set(c, 'Position', pos);
end

function c = placeNodeColorBarSub()
    
    c = colorbar;
    set(c, 'Location', 'westoutside');
    
end