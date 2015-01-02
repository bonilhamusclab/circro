% --- creates renderings
function draw_circle(list_regions,v,sizes,colors,colorscheme)
axis square
delete(allchild(v.hAxes));%
set(v.hMainFigure,'CurrentAxes',v.hAxes)
set(0, 'CurrentFigure', v.hMainFigure);  %# for figures
    n=(size(list_regions,1)*(size(list_regions,2)));
    if nargin<3;
        % set constants
        r = 1;  % sets the outer radius
        list_sizes(1:n,1)=r*1.1; % sets the inner radius as 0.9 of R
    else
        r = 1;
        list_sizes(1:n/2,1)=sizes(1:end,1);
        list_sizes(1:n/2,2)=flipud(sizes(1:end,2));% flip the second column for sequential drawing of segments
        list_sizes=list_sizes+r;
    end
    if nargin>=4
        list_colors(1:n/2,1)=colors(1:end,1);
        list_colors(1:n/2,2)=flipud(colors(1:end,2));
        list_colors=[list_colors(1:n/2,1);list_colors(1:n/2,2)]; % organized into one single column 
       
    else
        list_colors=rand(n,1);
        list_colors(n/2,1)=0.5;% set the mid value as on (to set the color as the mid-value
    end
    if nargin<5
        colorscheme=hot;
    end
    start_radian=pi/2; %sets the origin of the first segment (could also be 0)
    end_radian=start_radian+(2*pi)/n; %sets the end of the first segment (could also be pi/2)
    % end constants
    
    axis square        
    for segment=1:n % draw the circle
        % map colors
        color=find_color_in_colorscheme(list_colors(segment),list_colors,colorscheme);           
        draw_segment(start_radian,end_radian,list_sizes(segment),r,color,[])
        start_radian=end_radian;
        end_radian=start_radian+(2*pi)/n;
        pause(0.01)
        hold on        
    end
    % add colorbar
    colormap(colorscheme)
    cb=colorbar;
    cbIm = findobj(cb,'Type','image');
    alpha(cbIm,0.5)
    % end add colorbar      
    R=max(list_sizes(:));
    axis([-2.3*R 2.3*R -2.3*R 2.3*R])
    axis square
    axis off