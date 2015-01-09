function setCircularEdgeMatrix(v, edgeMatrixFullPath, varargin)
matrix = fileUtils.loadMatrix(edgeMatrixFullPath);
v.matrix=matrix;

inputs = parseInputParamsSub(varargin);
threshold = inputs.threshold;
startRadian = inputs.startRadian;
radius = inputs.radius;


guidata(v.hMainFigure,v);
drawing.draw_links(matrix,threshold,startRadian,radius);

function inputParams = parseInputParamsSub(args)
p = inputParser;
d.threshold = .5; d.startRadian = 0; d.radius = 1;

validateChar = @(x) validateattributes(x, {'char'}, {});

p.addOptional('threshold', d.threshold, validateChar);
p.addOptional('startRadian', d.startRadian, validateChar);
p.addOptional('radius', d.radius, validateChar);

p = utils.stringSafeParse(p, args, fieldnames(d), ...
    d.threshold, d.startRadian, d.radius);

inputParams = p.Results;