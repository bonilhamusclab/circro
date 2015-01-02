% find value associated with a color
function color=find_color_in_colorscheme(value,range,colorscheme)
    cm_length=size(colorscheme,1); % length of the colormap
    cmin=min(range); % min
    cmax=max(range); % max
    csteps=linspace(cmin,cmax,cm_length); % incremental steps from min to max within the length of the colormap
    C_index = ( abs(value-csteps) == min(abs(value-csteps)) ); % find the closest step to value
    color=colorscheme(C_index,:); % color associated with value     
%end find_color_in_colorscheme