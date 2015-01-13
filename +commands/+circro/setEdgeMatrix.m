function setEdgeMatrix(v, edgeMatrixFullPath, varargin)
matrix = fileUtils.circro.loadMatrix(edgeMatrixFullPath);

inputs = parseInputParamsSub(varargin);
threshold = inputs.threshold;

v.edgeMatrix = matrix;
v.edgeThreshold = threshold;

guidata(v.hMainFigure,v);
drawing.circro.drawCircle(v);

function inputParams = parseInputParamsSub(args)
p = inputParser;
d.threshold = .5;

p.addOptional('threshold', d.threshold, @(x) validateattributes(x, {'numeric'},{'real'}));

p = utils.stringSafeParse(p, args, fieldnames(d), ...
    d.threshold);

inputParams = p.Results;
