function setEdgeMatrix(v, edgeMatrixFullPath, varargin)

matrix = fileUtils.circro.loadMatrix(edgeMatrixFullPath);

inputs = parseInputParamsSub(v, varargin);
threshold = inputs.threshold;
circleIndex = inputs.circleIndex;

v.circles{circleIndex}.edgeMatrix = matrix;
v.circles{circleIndex}.edgeThreshold = threshold;

if inputs.colorscheme
    colorscheme = str2func(inputs.colorscheme);
    v.circles{circleIndex}.edgeMatrixColorscheme = colorscheme();
end

guidata(v.hMainFigure,v);
drawing.circro.drawCircles(v);


function inputParams = parseInputParamsSub(v, args)
p = inputParser;
d.threshold = .5;
d.colorscheme = '';

d.circleIndex = utils.circro.addCircleIndexInputCheck(v, p);

p.addOptional('threshold', d.threshold, @(x) validateattributes(x, {'numeric'},{'real'}));
p.addOptional('colorscheme', d.colorscheme, ...
    utils.validOrEmptyFnGen(utils.colorMapNames, 'setEdgeMatrix', 'colorscheme'));

p = utils.stringSafeParse(p, args, fieldnames(d), ...
    d.threshold, d.circleIndex, d.colorscheme);

inputParams = p.Results;
