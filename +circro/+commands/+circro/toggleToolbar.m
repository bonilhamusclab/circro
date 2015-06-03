function toggleToolbar(v, varargin)
%inputs: 
%   toolbar (optional)
%       default: toggle b/w auto and figure
%       acceptable values: auto, none, figure

	inputs = parseInputParamsSub(varargin);
    toolbar = inputs.toolbar;

	set(gcf, 'Toolbar', toolbar);
	v.Toolbar = toolbar;

	guidata(v.hMainFigure, v);
end

function inputParams = parseInputParamsSub(args)
    p = inputParser;
    
    currToolbar = get(gcf, 'Toolbar');
    
    d.toolbar = 'none';
    if ~strcmpi(currToolbar,'figure')
        d.toolbar = 'figure';
    end

    p.addOptional('toolbar', d.toolbar, ...
        @(x) validatestring(x, {'auto', 'none', 'figure'}));

    p = circro.utils.stringSafeParse(p, args, fieldnames(d), d.toolbar);

    inputParams = p.Results;

end