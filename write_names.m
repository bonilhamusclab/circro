function write_names(list_regions,radius,start_radian)
    regions=[list_regions(:,1);flipud(list_regions(:,2))]; % flip right hemisphere regions
    number_regions=size(regions,1);
    for i=1:number_regions        
        theta=  ( (start_radian + ( (i-1) *(2*pi/number_regions) ))...
            + (start_radian + ( (i *(2*pi/number_regions) )) ))/2 ;       
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
