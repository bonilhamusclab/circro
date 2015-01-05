function draw_segment(start,term,R,r,color,height)
    
    seg = linspace( start, term, 100);
    %outer rim
    if isempty(height)
        height=0;
    end
    x_1 = (R+height)*cos(seg) ;
    y_1 = (R+height)*sin(seg) ;
    %inner rim
    x_2 = r*cos(seg) ;
    y_2 = r*sin(seg) ;
    % flip inner rim
    x_2=flipdim(x_2,2);
    y_2=flipdim(y_2,2);

    X=[x_1 x_2];
    Y=[y_1 y_2];

    pol=fill(X,Y,'r');
    
    if ~isempty(color)
        set(pol,'FaceColor',color)
    end
    
    set(pol,'EdgeColor','k')
    set(pol,'FaceAlpha',0.4)

end % draw_segment

