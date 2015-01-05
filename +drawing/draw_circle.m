% --- creates renderings
function draw_circle(v,node_sequence,node_sizes,node_colors,colorscheme)
    axis square
    delete(allchild(v.hAxes));%
    set(v.hMainFigure,'CurrentAxes',v.hAxes)
    set(0, 'CurrentFigure', v.hMainFigure);  %# for figures
    fprintf('Drawing circle with %d regions\n',numel(node_sequence))
    num_nodes=numel(node_sequence);
    inner_r = 1;
    if nargin<3;
        node_sizes(1:num_nodes,1)=inner_r*1.1;
    else
        tmp = node_sizes;
        node_sizes(1:num_nodes/2,1)=tmp(1:end,1);
        node_sizes(1:num_nodes/2,2)=flipud(tmp(1:end,2));% flip the second column for sequential drawing of segments
        node_sizes=node_sizes+inner_r;
    end
    if nargin>=4
        list_colors(1:num_nodes/2,1)=node_colors(1:end,1);
        list_colors(1:num_nodes/2,2)=flipud(node_colors(1:end,2));
        list_colors=[list_colors(1:num_nodes/2,1); list_colors(1:num_nodes/2,2)]; % organized into one single column 
       
    else
        list_colors=rand(num_nodes,1);
        list_colors(num_nodes/2,1)=0.5;% set the mid value as on (to set the color as the mid-value
    end
    if nargin<5
        colorscheme=hot;
    end
    start_radian=pi/2; %sets the origin of the first segment (could also be 0)
    end_radian=start_radian+(2*pi)/num_nodes; %sets the end of the first segment (could also be pi/2)
    % end constants
    
    axis square        
    for segment=1:num_nodes % draw the circle
        % map colors
        color=find_color_in_colorscheme(list_colors(segment),list_colors,colorscheme);           
        drawing.draw_segment(start_radian,end_radian,node_sizes(segment),inner_r,color,[])
        start_radian=end_radian;
        end_radian=start_radian+(2*pi)/num_nodes;
        pause(0.01)
        hold on        
    end
    % add colorbar
    colormap(colorscheme)
    cb=colorbar;
    cbIm = findobj(cb,'Type','image');
    alpha(cbIm,0.5)
    % end add colorbar      
    R=max(node_sizes(:));
    axis([-2.3*R 2.3*R -2.3*R 2.3*R])
    axis square
    axis off
