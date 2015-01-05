function addCircle(v, list_full_path)
    
    [~, list_regions]=xlsread(list_full_path);
    
    v.number_region=numel(list_regions); 
    v.list_regions=list_regions;
    guidata(v.hMainFigure,v)
    drawing.draw_circle(v, list_regions); % write circle with the regions listed
    write_names(list_regions,1.2,pi/2);