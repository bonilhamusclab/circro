% --- Save screenshot as bitmap image
function saveBitmap(v, filename, varargin)
% inputs: filename, dpi (optional, defaults to 900)

inputParams = parseInputParamsSub(varargin);

dpi = sprintf('-r%d', inputParams.dpi);

print(v.hMainFigure, dpi, '-dpng', filename);

end

function inputParams = parseInputParamsSub(args)
    p = inputParser;
    
    d.dpi = 900;
    
    p.addOptional('dpi', d.dpi, @(x) validateattributes(x, {'numeric'}, {'real'}));
    
    p = utils.stringSafeParse(p, args, fieldnames(d), d.dpi);
    
    inputParams = p.Results;
end