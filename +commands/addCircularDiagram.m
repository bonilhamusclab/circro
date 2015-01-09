function addCircularDiagram(v, varargin)
    
    inputs = parseInputParamsSub(varargin);
    labelsFullPath = inputs.labelsFullPath;
    sizesFullPath = inputs.sizesFullPath;
    edgeMatrixFullPath = inputs.edgeMatrixFullPath;
    colorsFullPath = inputs.colorsFullPath;
    
    if labelsFullPath
        commands.setCircularNodeLabels(v, labelsFullPath);
    end
    
    if sizesFullPath
        commands.setCircularNodeSizes(v, sizesFullPath);
    end
    
    if edgeMatrixFullPath
        commands.setCircularEdgeMatrix(v, edgeMatrixFullPath);
    end
    
    if colorsFullPath
        commands.setCircularNodeColors(v, colorsFullPath);
    end
end

function inputParams = parseInputParamsSub(args)
p = inputParser;
d.labelsFullPath = ''; d.sizesFullPath = ''; d.edgeMatrixFullPath = ''; d.colorsFullPath = '';

validateChar = @(x) validateattributes(x, {'char'}, {});

p.addOptional('labelsFullPath', d.labelsFullPath, validateChar);
p.addOptional('sizesFullPath', d.labelsFullPath, validateChar);
p.addOptional('edgeMatrixFullPath', d.labelsFullPath, validateChar);
p.addOptional('colorsFullPath', d.labelsFullPath, validateChar);

p = utils.stringSafeParse(p, args, fieldnames(d), ...
    d.labelsFullPath, d.sizesFullPath, d.edgeMatrixFullPath, d.colorsFullPath);

inputParams = p.Results;

end