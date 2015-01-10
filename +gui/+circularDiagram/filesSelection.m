function varargout = filesSelection(varargin)
% FILESSELECTION MATLAB code for filesSelection.fig
%      FILESSELECTION, by itself, creates a new FILESSELECTION or raises the existing
%      singleton*.
%
%      H = FILESSELECTION returns the handle to a new FILESSELECTION or the handle to
%      the existing singleton*.
%
%      FILESSELECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILESSELECTION.M with the given input arguments.
%
%      FILESSELECTION('Property','Value',...) creates a new FILESSELECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before filesSelection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to filesSelection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help filesSelection

% Last Modified by GUIDE v2.5 10-Jan-2015 07:55:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       '+gui/+circularDiagram/filesSelection.fig', ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @filesSelection_OpeningFcn, ...
                   'gui_OutputFcn',  @filesSelection_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

function setBoundField(h, field, value)
    handles = guidata(h);
    handles.(field) = value;
    guidata(handles.output, handles);
    
    boundFns = handles.boundFns;
    if isfield(boundFns, field)
        fnsForField = boundFns.(field);
        for i = 1: size(fnsForField, 2)
            fn = fnsForField{i};
            fn(value);
        end
    end
    guidata(h, handles);
end

function bind(h, field, fns)
    handles = guidata(h);
    if ~isfield(handles, 'boundFns')
        handles.boundFns = {};
    end
    orig_fns = {};
    if isfield(handles.boundFns, field)
        orig_fns = handles.boundFns.(field);
    end
    handles.boundFns.(field) = [orig_fns fns];
    guidata(h, handles);
end

%So that invoking function has caccess to data
function callerSetters(h, setLabelsFn, setSizesFn, setEdgeMatrixFn, setColorsFn)
    bind(h, 'labelsFile', {setLabelsFn});
    bind(h, 'sizesFile', {setSizesFn});
    bind(h, 'edgeMatrixFile', {setEdgeMatrixFn});
    bind(h, 'colorsFile', {setColorsFn});
end

function bindTextBoxes(h)
    handles = guidata(h);
    
    function fn = updateTexBoxFnGen(field)
        function updateTextBox(value)
            handles.([field 'Path_txtbox']).String = value;
        end
        fn = @updateTextBox;
    end
    
    fields = {'labelsFile', 'sizesFile', 'edgeMatrixFile', 'colorsFile'};
    cellfun(@(f) bind(h, f, {updateTexBoxFnGen(f)}), fields, ...
        'UniformOutput', 0);
end

% --- Executes just before filesSelection is made visible.
function filesSelection_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to filesSelection (see VARARGIN)

% Choose default command line output for filesSelection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
    
callerSetters(handles.output, varargin{:});

bindTextBoxes(handles.output);

% UIWAIT makes filesSelection wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end


function varargout = filesSelection_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

function selectFile(fileType, handleField, h)
    [data_filename, data_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    sprintf('Select a %s file',fileType));
    if isequal(data_filename,0)
        return;
    else
        fullpath = [data_pathname data_filename];
        setBoundField(h, handleField, fullpath);
    end
end

% --- Executes on button press in selectSizesFile_button.
function selectLabelsFile_button_Callback(~, ~, handles)
% hObject    handle to selectSizesFile_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    selectFile('Labels', 'labelsFile', handles.output);
end

% --- Executes on button press in selectSizesFile_button.
function selectSizesFile_button_Callback(~, ~, handles)
% hObject    handle to selectSizesFile_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    selectFile('Sizes', 'sizesFile', handles.output);
end


% --- Executes on button press in selectEdgeMatrixFile_button.
function selectEdgeMatrixFile_button_Callback(~, ~, handles)
% hObject    handle to selectEdgeMatrixFile_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    selectFile('Edge Matrix', 'edgeMatrixFile', handles.output);
end


% --- Executes on button press in selectColorsFile_button.
function selectColorsFile_button_Callback(~, ~, handles)
% hObject    handle to selectColorsFile_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
    selectFile('Sizes', 'colorsFile', handles.output);
end

function prepForWindowsOs(hObject)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes during object creation, after setting all properties.
function labelsFilePath_txtbox_CreateFcn(hObject, ~, ~)
% hObject    handle to sizesFilePath_txtbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    prepForWindowsOs(hObject);
end

% --- Executes during object creation, after setting all properties.
function sizesFilePath_txtbox_CreateFcn(hObject, ~, ~)
% hObject    handle to sizesFilePath_txtbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    prepForWindowsOs(hObject);
end

% --- Executes during object creation, after setting all properties.
function colorsFilePath_txtbox_CreateFcn(hObject, ~, ~)
% hObject    handle to colorsFilePath_txtbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    prepForWindowsOs(hObject);
end

% --- Executes during object creation, after setting all properties.
function edgeMatrixFilePath_txtbox_CreateFcn(hObject, ~, ~)
% hObject    handle to edgeMatrixFilePath_txtbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
    prepForWindowsOs(hObject);
end
