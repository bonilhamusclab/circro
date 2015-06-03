function parser = stringSafeParse(parser, args, fieldNames, varargin)
%function parser = stringSafeParse(parser, args, fieldNames, varargin)

isArgsNameValue = circro.utils.isArgsNameValue(args, fieldNames);

if ~isArgsNameValue
    args = circro.utils.emptyToDefaults(args, varargin{:});
end

parse(parser, args{:});