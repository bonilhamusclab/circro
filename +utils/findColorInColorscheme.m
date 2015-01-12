% find value associated with a color
function color=findColorInColorscheme(value,range,colorscheme)
    cmLength=size(colorscheme,1); % length of the colormap
    cmin=min(range); % min
    cmax=max(range); % max
    csteps=linspace(cmin,cmax,cmLength); % incremental steps from min to max within the length of the colormap
    CIndex = ( abs(value-csteps) == min(abs(value-csteps)) ); % find the closest step to value
    color=colorscheme(CIndex,:); % color associated with value     
%end findColorInColorscheme
