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

% Last Modified by GUIDE v2.5 12-Jan-2015 19:59:29

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
function callerSetters(h, fns)
    bind(h, 'labelsFile', {fns.setLabelsFn});
    bind(h, 'sizesFile', {fns.setSizesFn});
    bind(h, 'edgeMatrixFile', {fns.setEdgeMatrixFn});
    bind(h, 'colorsFile', {fns.setColorsFn});
    bind(h, 'edgeThreshold', {fns.setEdgeThresholdFn});
    bind(h, 'radius', {fns.setRadiusFn});
    bind(h, 'labelRadius', {fns.setLabelRadiusFn});
    bind(h, 'startRadian', {fns.setStartRadianFn});
end

function bindTextBoxes(h)
    handles = guidata(h);
    
    function fn = updateTexBoxFnGen(field)
        function updateTextBox(value)
            handles.([field 'Path_txtbox']).String = value;
        end
        fn = @updateTextBox;
    end
    
    fields = handles.fields;
    cellfun(@(f) bind(h, f, {updateTexBoxFnGen(f)}), fields, ...
        'UniformOutput', 0);
end

function anySet = anyFieldSet(handles)
	fields = handles.fields;

    function a = any(cells)
        a = 0;
        for i = 1:length(cells)
            if cells{i}
                a = 1;
                break;
            end
        end
    end

    anySet = 0;
    if any(cellfun(@(f) exist(handles.([f 'Path_txtbox']).String, 'file'), ...
            fields, 'UniformOutput', 0));
            anySet = 1;
    end
end

function bindEnabledToAnyFieldSet(h, control)
    handles = guidata(h);
	fields = handles.fields;
    
    cellfun(@(f) bind(h, f, {@toggle}), fields, ...
        'UniformOutput', 0);
        
    function toggle(~)
        handles = guidata(h);

        Enable = 'off';
        if anyFieldSet(handles);
            Enable = 'on';
        end
        control.Enable = Enable;
    end
end

function bindOkButtonEnabled(h)
    handles = guidata(h);
    bindEnabledToAnyFieldSet(h, handles.okPushbutton);
end

function bindDimensionOptions(h)
    handles = guidata(h);
    bindEnabledToAnyFieldSet(h, handles.radius_edit);
    bindEnabledToAnyFieldSet(h, handles.labelRadius_edit);
end

function bindEdgeMatrixOptions(h)
    handles = guidata(h);
    bindEnabledToAnyFieldSet(h, handles.edgeThreshold_edit);
    bindEnabledToAnyFieldSet(h, handles.viewEdgeMatrixCdf_pushbutton);
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
handles.fields = {'labelsFile', 'sizesFile', 'edgeMatrixFile', 'colorsFile'};

% Update handles structure
guidata(hObject, handles);

setterFns = varargin{1};
callerSetters(handles.output, setterFns);

bindTextBoxes(handles.output);

bindOkButtonEnabled(handles.output);

bindDimensionOptions(handles.output);

bindEdgeMatrixOptions(handles.output);

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


% --- Executes on button press in okPushbutton.
function okPushbutton_Callback(~, ~, handles)
% hObject    handle to okPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.output);
end

% --- Executes on button press in cancelPushbutton.
function cancelPushbutton_Callback(~, ~, handles)
% hObject    handle to cancelPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fields = handles.fields;
h = handles.output;
cellfun(@(f)setBoundField(h, f, ''), fields);
close(handles.output);
end



function radius_edit_Callback(hObject, ~, handles)
% hObject    handle to radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_edit as text
%        str2double(get(hObject,'String')) returns contents of radius_edit as a double

setBoundField(handles.output, 'radius', get(hObject, String));

end


% --- Executes during object creation, after setting all properties.
function radius_edit_CreateFcn(hObject, ~, handles)
% hObject    handle to radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
prepForWindowsOs();
end



% --- Executes during object creation, after setting all properties.
function labelRadius_edit_CreateFcn(~, ~, ~)
% hObject    handle to labelRadius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

prepForWindowsOs();
end


function edgeThreshold_edit_Callback(hObject, ~, handles)
% hObject    handle to edgeThreshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edgeThreshold_edit as text
%        str2double(get(hObject,'String')) returns contents of edgeThreshold_edit as a double
newThresh = str2double(get(hObject,'String'));
setBoundField(handles.output, 'edgeThreshold', newThresh);
end

% --- Executes during object creation, after setting all properties.
function edgeThreshold_edit_CreateFcn(hObject, ~, handles)
% hObject    handle to edgeThreshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

prepForWindowsOs();
end


% --- Executes on button press in viewEdgeMatrixCdf_pushbutton.
function viewEdgeMatrixCdf_pushbutton_Callback(~, ~, handles)
% hObject    handle to viewEdgeMatrixCdf_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

edges = fileUtils.loadMatrix(handles.edgeMatrixFile);
figure;
normplot(edges(:));

end


function labelRadius_edit_Callback(hObject, ~, handles)
% hObject    handle to labelRadius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of labelRadius_edit as text
%        str2double(get(hObject,'String')) returns contents of labelRadius_edit as a double

setBoundField(handles.output, 'labelRadius', get(hObject, String));

end
