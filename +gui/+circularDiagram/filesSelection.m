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

% Last Modified by GUIDE v2.5 09-Jan-2015 00:36:43

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

%So that invoking function has caccess to data
function handles = callerSetters(handles, setLabelsFn, setSizesFn, setEdgeMatrixFn, setColorsFn)
handles.setLabelsFn = setLabelsFn;
handles.setSizesFn = setSizesFn;
handles.setEdgeMatrixFn = setEdgeMatrixFn;
handles.setColorsFn = setColorsFn;

% --- Executes just before filesSelection is made visible.
function filesSelection_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to filesSelection (see VARARGIN)

% Choose default command line output for filesSelection
handles.output = hObject;
    
handles = callerSetters(handles, varargin{:});

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes filesSelection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function varargout = filesSelection_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function selectFile(fileType, handleField, setterFn, handles)
    [data_filename, data_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    sprintf('Select a %s file',fileType));
    if isequal(data_filename,0)
        return;
    else
        fullpath = [data_pathname data_filename];
        setterFn(fullpath);
        handles.(handleField) = fullpath;
        guidata(handles.output, handles);
    end
    

% --- Executes on button press in selectSizesFile_button.
function selectLabelsFile_button_Callback(~, ~, handles)
% hObject    handle to selectSizesFile_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectFile('Labels', 'labelsFile', handles.setLabelsFn, handles);

% --- Executes on button press in selectSizesFile_button.
function selectSizesFile_button_Callback(~, ~, handles)
% hObject    handle to selectSizesFile_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectFile('Sizes', 'sizesFile', handles.setSizesFn, handles);


% --- Executes on button press in selectEdgeMatrixFile_button.
function selectEdgeMatrixFile_button_Callback(~, ~, handles)
% hObject    handle to selectEdgeMatrixFile_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectFile('Edge Matrix', 'edgeMatrixFile', handles.setEdgeMatrixFn, handles);



% --- Executes on button press in selectColorsFile_button.
function selectColorsFile_button_Callback(~, ~, handles)
% hObject    handle to selectColorsFile_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
selectFile('Sizes', 'sizesFile', handles.setSizesFn, handles);


function prepForWindowsOs(hObject)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function labelsFilePath_txtbox_CreateFcn(hObject, ~, handles)
% hObject    handle to sizesFilePath_txtbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
prepForWindowsOs(hObject);


% --- Executes during object creation, after setting all properties.
function sizesFilePath_txtbox_CreateFcn(hObject, ~, handles)
% hObject    handle to sizesFilePath_txtbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
prepForWindowsOs(hObject);


% --- Executes during object creation, after setting all properties.
function colorsFilePath_txtbox_CreateFcn(hObject, ~, handles)
% hObject    handle to colorsFilePath_txtbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
prepForWindowsOs(hObject);


% --- Executes during object creation, after setting all properties.
function edgeMatrxPath_txt_CreateFcn(hObject, ~, handles)
% hObject    handle to edgeMatrxPath_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
prepForWindowsOs(hObject);
