function setCircularEdgeMatrix(v, edgeMatrixFullPath, varargin)
matrix = fileUtils.loadMatrix(edgeMatrixFullPath);
v.matrix=matrix;

inputs = parseInputParamsSub(varargin);
threshold = inputs.threshold;
startRadian = inputs.startRadian;
radius = inputs.radius;


guidata(v.hMainFigure,v);
drawing.drawLinks(matrix,threshold,startRadian,radius);

function inputParams = parseInputParamsSub(args)
p = inputParser;
d.threshold = .5; d.startRadian = 0; d.radius = 1;

p.addOptional('threshold', d.threshold, @(x) validateattributes(x, {'numeric'},{'<=', 1, '>=', 0}));
p.addOptional('startRadian', d.startRadian, @(x) validateattributes(x, {'numeric'}, {'real'}));
p.addOptional('radius', d.radius, @(x) validateattributes(x, {'numeric'}, {'real'}));

p = utils.stringSafeParse(p, args, fieldnames(d), ...
    d.threshold, d.startRadian, d.radius);

inputParams = p.Results;