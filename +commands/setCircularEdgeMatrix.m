function setCircularEdgeMatrix(v, edgeMatrixFullPath, varargin)
matrix = fileUtils.loadMatrix(edgeMatrixFullPath);

inputs = parseInputParamsSub(varargin);
threshold = inputs.threshold;

v.links.edgeMatrix = matrix;
v.links.threshold = threshold;

guidata(v.hMainFigure,v);
drawing.drawCircle(v);

function inputParams = parseInputParamsSub(args)
p = inputParser;
d.threshold = .5;

p.addOptional('threshold', d.threshold, @(x) validateattributes(x, {'numeric'},{'real'}));

p = utils.stringSafeParse(p, args, fieldnames(d), ...
    d.threshold);

inputParams = p.Results;