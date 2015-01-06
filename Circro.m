function varargout = Circro(varargin)
mOutputArgs = {}; % Variable for storing output when GUI returns
h = findall(0,'tag',mfilename); %run as singleton
if (isempty(h)) % new instance
   h = gui.makeGUI(); %set up user interface
else % instance already running
   figure(h);  %Figure exists so bring Figure to the focus
end
if (nargin) && (ischar(varargin{1})) 
 f = str2func(['commands.' varargin{1}]);
 f(guidata(h),varargin{2:nargin})
end
mOutputArgs{1} = h;% return handle to main figure
if nargout>0
 [varargout{1:nargout}] = mOutputArgs{:};
end
%end Circro
