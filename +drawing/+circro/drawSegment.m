function drawSegment(start,term,R,r,color,height)
    
    seg = linspace( start, term, 100);
    %outer rim
    if isempty(height)
        height=0;
    end
    x1 = (R+height)*cos(seg) ;
    y1 = (R+height)*sin(seg) ;
    %inner rim
    x2 = r*cos(seg) ;
    y2 = r*sin(seg) ;
    % flip inner rim
    x2=flipdim(x2,2);
    y2=flipdim(y2,2);

    X=[x1 x2];
    Y=[y1 y2];

    pol=fill(X,Y,'r');
    
    if ~isempty(color)
        set(pol,'FaceColor',color)
    end
    
    set(pol,'EdgeColor','k')
    set(pol,'FaceAlpha',0.4)

end % drawSegment

