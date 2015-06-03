function varargout = Circro(varargin)

mOutputArgs = {}; % Variable for storing output when GUI returns
h = gui.getGuiHandle(); 
if (isempty(h)) % new instance
    h = gui.makeGui(); %set up user interface
else % instance already running
   figure(h);  %Figure exists so bring Figure to the focus
end;
if (nargin) && (ischar(varargin{1})) 
 funcName = varargin{1};
 %fnPath = strcat('commands.',funcName);
 f = str2func(strcat('commands.', funcName));
 v = guidata(h);
 
 histIx = circro.utils.fieldIndex(v, 'history');
 v.history(histIx) = {varargin};
 guidata(h, v);
 
 
 f(v, varargin{2:nargin})
end
mOutputArgs{1} = h;% return handle to main figure
if nargout>0
 [varargout{1:nargout}] = mOutputArgs{:};
end
