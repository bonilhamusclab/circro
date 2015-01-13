function addDiagram(v, varargin)
    
    inputs = parseInputParamsSub(v, varargin);
    labelsFullPath = inputs.labelsFullPath;
    sizesFullPath = inputs.sizesFullPath;
    edgeMatrixFullPath = inputs.edgeMatrixFullPath;
    colorsFullPath = inputs.colorsFullPath;
    edgeThreshold = inputs.edgeThreshold;
    circleIndex = inputs.circleIndex;
    
    if isempty(labelsFullPath) && isempty(sizesFullPath) && isempty(edgeMatrixFullPath) && isempty(colorsFullPath)
        error('a labels, sizes, edge matrix, or colors file must be specified');
    end
    
    
    h = v.hMainFigure;
    
    if labelsFullPath
        commands.circro.setNodeLabels(guidata(h), labelsFullPath, circleIndex);
    end
    
    if sizesFullPath
        commands.circro.setNodeSizes(guidata(h), sizesFullPath, circleIndex);
    end
    
    if edgeMatrixFullPath
        commands.circro.setEdgeMatrix(guidata(h), edgeMatrixFullPath, edgeThreshold, circleIndex);
    end
    
    if colorsFullPath
        commands.circro.setNodeColors(guidata(h), colorsFullPath, circleIndex);
    end
end

function inputParams = parseInputParamsSub(v, args)
p = inputParser;
d.labelsFullPath = ''; d.sizesFullPath = ''; d.edgeMatrixFullPath = ''; d.colorsFullPath = '';
d.edgeThreshold = .5;
d.circleIndex = utils.fieldIndex(v, 'circles');

validateChar = @(x) validateattributes(x, {'char'}, {});

p.addOptional('labelsFullPath', d.labelsFullPath, validateChar);
p.addOptional('sizesFullPath', d.labelsFullPath, validateChar);
p.addOptional('edgeMatrixFullPath', d.labelsFullPath, validateChar);
p.addOptional('colorsFullPath', d.labelsFullPath, validateChar);
p.addOptional('edgeThreshold', d.edgeThreshold, @(x) validateattributes(x, {'numeric'}, {'real'}));
p.addOptional('circleIndex', d.circleIndex, @(x) validateattributes(x, {'numeric'}, {'positive', 'integer'}));

p = utils.stringSafeParse(p, args, fieldnames(d), ...
    d.labelsFullPath, d.sizesFullPath, d.edgeMatrixFullPath, d.colorsFullPath, d.edgeThreshold, d.circleIndex);

inputParams = p.Results;

end
