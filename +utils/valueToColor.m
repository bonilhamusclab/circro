function color=valueToColor(value,range,colorscheme)
%function color=valueToColor(value,range,colorscheme)
    numSteps=size(colorscheme,1);
    quantizedValues=linspace(min(range),max(range),numSteps);
    [~, cIndex] = min(abs(value-quantizedValues));
    color=colorscheme(cIndex,:);
end