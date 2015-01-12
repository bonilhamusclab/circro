function writeNames(labels,radius,start_radian)
    regions=[labels(:,1);flipud(labels(:,2))]; % flip right hemisphere regions
    number_labels=size(regions,1);
    for i=1:number_labels        
        theta=  ( (start_radian + ( (i-1) *(2*pi/number_labels) ))...
            + (start_radian + ( (i *(2*pi/number_labels) )) ))/2 ;       
        x = radius * cos(theta);
        y = radius * sin(theta);        
        if ischar(regions{i})
            name=regions{i};
        else
            name=num2str(regions{i});
        end        
        text(x*(1.1), y*(1.1), name, 'HorizontalAlignment','center','FontSize',10)               
    end    
% end write names
