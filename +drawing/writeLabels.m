function writeLabels(v, radius,startRadian)
    labels = v.labels;
    regions=[labels(:,1);flipud(labels(:,2))]; % flip right hemisphere regions
    numberLabels=size(regions,1);
    for i=1:numberLabels        
        theta=  ( (startRadian + ( (i-1) *(2*pi/numberLabels) ))...
            + (startRadian + ( (i *(2*pi/numberLabels) )) ))/2 ;       
        x = radius * cos(theta);
        y = radius * sin(theta);        
        if ischar(regions{i})
            name=regions{i};
        else
            name=num2str(regions{i});
        end        
        text(x*(1.1), y*(1.1), name, 'HorizontalAlignment','center','FontSize',10)               
    end    
% end write labels
