function writeLabels(labels, radius,startRadian)
    regions=[labels(:,1); flipud(labels(:,2))];
    numberLabels=size(regions,1);
    radiansPerLabel = 2 * pi/numberLabels;
    for i=1:numberLabels
        theta = startRadian + (i-1)*radiansPerLabel + radiansPerLabel/2;
        x = radius * cos(theta);
        y = radius * sin(theta);        
        if ischar(regions{i})
            name=regions{i};
        else
            name=num2str(regions{i});
        end
        
        %%Special Thanks to JC Mosher for the text alignment
        %%https://github.com/bonilhamusclab/circro/issues/1
        textRotation = theta/pi * 180;
        alignment = 'left';
        if cos(theta) < 0
            textRotation = textRotation + 180;
            alignment = 'right';
        end
        %%
        
        text(x*(1.1), y*(1.1), name, 'FontSize',10, ...
            'HorizontalAlignment', alignment, 'Rotation', textRotation);
    end    
end