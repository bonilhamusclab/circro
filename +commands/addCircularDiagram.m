function addCircularDiagram(v, varargin)
    
    inputs = parseInputParamsSub(varargin);
    labelsFullPath = inputs.labelsFullPath;
    sizesFullPath = inputs.sizesFullPath;
    edgeMatrixFullPath = inputs.edgeMatrixFullPath;
    colorsFullPath = inputs.colorsFullPath;

    labels=fileUtils.loadLabels(labelsFullPath);
    
    v.number_region=numel(labels); 
    v.list_regions=labels;
    guidata(v.hMainFigure,v)
    drawing.draw_circle(v, labels); % write circle with the regions listed
    drawing.write_names(labels,1.2,pi/2);
end

function inputParams = parseInputParamsSub(args)
p = inputParser;
d.labelsFullPath = ''; d.sizesFullPath = ''; d.edgeMatrixFullPath = ''; d.colorsFullPath = '';

p.addOptional('labelsFullPath', d.labelsFullPath, ...
    @(x) validateattributes(x, {'char'}, {'nonempty'}));
p.addOptional('sizesFullPath', d.labelsFullPath, ...
    @(x) validateattributes(x, {'char'}, {'nonempty'}));
p.addOptional('edgeMatrixFullPath', d.labelsFullPath, ...
    @(x) validateattributes(x, {'char'}, {'nonempty'}));
p.addOptional('colorsFullPath', d.labelsFullPath, ...
    @(x) validateattributes(x, {'char'}, {'nonempty'}));
p = utils.stringSafeParse(p, args, fieldnames(d), ...
    d.labelsFullPath, d.sizesFullPath, d.edgeMatrixFullPath, d.colorsFullPath);

inputParams = p.Results;

end