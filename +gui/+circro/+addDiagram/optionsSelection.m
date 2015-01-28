function varargout = optionsSelection(varargin)
% OPTIONSSELECTION MATLAB code for filesSelection.fig
%      OPTIONSSELECTION, by itself, creates a new OPTIONSSELECTION or raises the existing
%      singleton*.
%
%      H = OPTIONSSELECTION returns the handle to a new OPTIONSSELECTION or the handle to
%      the existing singleton*.
%
%      OPTIONSSELECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTIONSSELECTION.M with the given input arguments.
%
%      OPTIONSSELECTION('Property','Value',...) creates a new OPTIONSSELECTION or raises the
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

% Last Modified by GUIDE v2.5 27-Jan-2015 23:19:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       '+gui/+circro/+addDiagram/optionsSelection.fig', ...
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

function bind(h, field, fn)
    handles = guidata(h);
    if ~isfield(handles, 'boundFns')
        handles.boundFns = {};
    end
    origFns = {};
    if isfield(handles.boundFns, field)
        origFns = handles.boundFns.(field);
    end
    handles.boundFns.(field) = [origFns {fn}];
    guidata(h, handles);
end

%So that invoking function has caccess to data
function callerSetters(h, fns)
    bind(h, 'labelsFile', fns.setLabelsFn);
    bind(h, 'sizesFile', fns.setSizesFn);
    bind(h, 'edgeMatrixFile', fns.setEdgeMatrixFn);
    bind(h, 'colorsFile', fns.setColorsFn);
    bind(h, 'edgeThreshold', fns.setEdgeThresholdFn);
    bind(h, 'radius', fns.setRadiusFn);
    bind(h, 'labelRadius', fns.setLabelRadiusFn);
    bind(h, 'startRadian', fns.setStartRadianFn);
    bind(h, 'edgeMatrixColorscheme', fns.setEdgeMatrixColorschemeFn);
    bind(h, 'nodeColorsColorscheme', fns.setNodeColorsColorschemeFn);
end

function bindTextBoxes(h)
    handles = guidata(h);
    
    function fn = updateTextBoxFnGen(field)
        function updateTextBox(value)
            set(handles.([field 'Path_txtbox']), 'String', value);
        end
        fn = @updateTextBox;
    end
    
    pathFields = handles.pathFields;
    cellfun(@(f) bind(h, f, updateTextBoxFnGen(f)), pathFields, ...
        'UniformOutput', 0);
end

function anySet = anyPathFieldSetToFile(handles)
	pathFields = handles.pathFields;

    anySet = 0;

    function a = anyCells(cells)
        a = 0;
        for i = 1:length(cells)
            if cells{i}
                a = 1;
                break;
            end
        end
	end

    if anyCells(cellfun(@(f) exist(get(handles.([f 'Path_txtbox']), 'String'), 'file'), ...
            pathFields, 'UniformOutput', 0));
            anySet = 1;
    end
end

function bindEnabledToAnyPathFieldSet(h, control)
    handles = guidata(h);
	pathFields = handles.pathFields;
    
    cellfun(@(f) bind(h, f, @toggle), pathFields, ...
        'UniformOutput', 0);
        
    function toggle(~)
        handles = guidata(h);

        Enable = 'off';
        if anyPathFieldSetToFile(handles);
            Enable = 'on';
        end
        set(control, 'Enable', Enable);
    end
end

function bindOkButtonEnable(h)
    handles = guidata(h);
    bindEnabledToAnyPathFieldSet(h, handles.okPushbutton);
end

function bindDimensionOptions(h)
    handles = guidata(h);
    bindEnabledToAnyPathFieldSet(h, handles.radius_edit);
    bindEnabledToAnyPathFieldSet(h, handles.labelRadius_edit);
    bindEnabledToAnyPathFieldSet(h, handles.startRadian_edit);
end

function bindControlEnableToField(h, field, controlName)
    function toggle(val)
        handles = guidata(h);
        Enable = 'off';
        if val
            Enable = 'on';
        end
        set(handles.(controlName), 'Enable', Enable);
    end
    bind(h, field, @toggle);
end

function fn = updateEditFnGen(h, field)
    function updateEditFn(value)
        handles = guidata(h);
        set(handles.([field '_edit']), 'String', num2str(value));
        guidata(h, handles);
    end
    fn = @updateEditFn;
end

function bindEdgeMatrixOptions(h)
    bind(h, 'edgeThreshold', updateEditFnGen(h, 'edgeThreshold'));
    bindControlEnableToField(h, 'edgeMatrixFile', 'edgeThreshold_edit');
    bindControlEnableToField(h, 'edgeMatrixFile', 'viewEdgeMatrixCdf_pushbutton');
    bindControlEnableToField(h, 'edgeMatrixFile', 'edgeMatrixColormap_popupmenu');
end

function bindResetFilesEnable(h)
    bindControlEnableToField(h, 'labelsFile', 'resetLabelsFile_pushbutton');
    bindControlEnableToField(h, 'sizesFile', 'resetSizesFile_pushbutton');
    bindControlEnableToField(h, 'colorsFile', 'resetColorsFile_pushbutton');
    bindControlEnableToField(h, 'edgeMatrixFile', 'resetEdgeMatrixFile_pushbutton');
end

function bindDimensions(h)
    fnMap.labelsFile = @fileUtils.circro.loadLabels;
    fnMap.sizesFile = @fileUtils.circro.loadSizes;
    fnMap.colorsFile = @fileUtils.circro.loadColors;
    fnMap.edgeMatrixFile = @fileUtils.circro.loadMatrix;
    
    fieldMap.labelsFile = 'nodeLabels';
    fieldMap.sizesFile = 'nodeSizes';
    fieldMap.colorsFile = 'nodeColors';
    fieldMap.edgeMatrixFile = 'edgeMatrix';
    
    function circleState = mockCircleState()
        handles = guidata(h);
        pathFields = handles.pathFields;
        for i = 1:length(pathFields)
            field = pathFields{i};
            if isfield(handles, field) && ~isempty(handles.(field))
                loadFn = fnMap.(field);
                circleField = fieldMap.(field);
                filePath = handles.(field);
                circle.(circleField) = loadFn(filePath);
            end
        end
        circleState = utils.circro.getCircleState(circle);
    end

    function updateDimensions(~)
        if anyPathFieldSetToFile(guidata(h))
            circleState = mockCircleState();
        else
            circleState.radius = '';
            circleState.labelRadius = '';
            circleState.startRadian = '';
        end
        setBoundField(h, 'radius', circleState.radius);
        setBoundField(h, 'labelRadius', circleState.labelRadius);
        setBoundField(h, 'startRadian', circleState.startRadian);
    end

    handles = guidata(h);

    cellfun(@(f) bind(h, f, @updateDimensions), handles.pathFields, ...
        'UniformOutput', 0);
end

function bindDimensionFields(h)

    bind(h, 'radius', updateEditFnGen(h, 'radius'));
    bind(h, 'labelRadius', updateEditFnGen(h, 'labelRadius'));
    bind(h, 'startRadian', updateEditFnGen(h, 'startRadian'));
end

function bindNodeColorsFields(h)
    bindControlEnableToField(h, 'colorsFile', 'nodeColorsColormap_popupmenu');
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
handles.pathFields = {'labelsFile', 'sizesFile', 'edgeMatrixFile', 'colorsFile'};
handles.edgeMatrixFields = {'edgeThreshold'};
handles.dimensionsFields = {'radius', 'labelRadius', 'startRadian'};
handles.allFields = [handles.pathFields, handles.edgeMatrixFields, handles.dimensionsFields];

% Update handles structure
guidata(hObject, handles);

setterFns = varargin{1};
callerSetters(handles.output, setterFns);

bindTextBoxes(handles.output);

bindOkButtonEnable(handles.output);

bindDimensionOptions(handles.output);

bindEdgeMatrixOptions(handles.output);

bindResetFilesEnable(handles.output);

bindDimensions(handles.output);

bindDimensionFields(handles.output);

bindNodeColorsFields(handles.output);

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
    selectFile('Colors', 'colorsFile', handles.output);
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
handles.closeFromOk = 1;
guidata(handles.output, handles);
close(handles.output);
end

function clearAllFields(handles)
    allFields = handles.allFields;
    h = handles.output;
    cellfun(@(f)setBoundField(h, f, ''), allFields);
end

% --- Executes on button press in cancelPushbutton.
function cancelPushbutton_Callback(~, ~, handles)
% hObject    handle to cancelPushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clearAllFields(handles);
handles.closeFromOk = 0;
guidata(handles.output, handles);
close(handles.output);
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
function edgeThreshold_edit_CreateFcn(hObject, ~, ~)
% hObject    handle to edgeThreshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

prepForWindowsOs(hObject);
end


% --- Executes on button press in viewEdgeMatrixCdf_pushbutton.
function viewEdgeMatrixCdf_pushbutton_Callback(~, ~, handles)
% hObject    handle to viewEdgeMatrixCdf_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

edges = fileUtils.circro.loadMatrix(handles.edgeMatrixFile);
figure;
normplot(edges(:));

end


% --- Executes during object creation, after setting all properties.
function radius_edit_CreateFcn(hObject, ~, ~)
% hObject    handle to radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
prepForWindowsOs(hObject);
end


function radius_edit_Callback(hObject, ~, handles)
% hObject    handle to radius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius_edit as text
%        str2double(get(hObject,'String')) returns contents of radius_edit as a double

setBoundField(handles.output, 'radius', str2double(get(hObject, 'String')));

end


% --- Executes during object creation, after setting all properties.
function labelRadius_edit_CreateFcn(hObject, ~, ~)
% hObject    handle to labelRadius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

prepForWindowsOs(hObject);
end


function labelRadius_edit_Callback(hObject, ~, handles)
% hObject    handle to labelRadius_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of labelRadius_edit as text
%        str2double(get(hObject,'String')) returns contents of labelRadius_edit as a double

setBoundField(handles.output, 'labelRadius', str2double(get(hObject, 'String')));

end



% --- Executes during object creation, after setting all properties.
function startRadian_edit_CreateFcn(hObject, ~, ~)
% hObject    handle to startRadian_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
prepForWindowsOs(hObject);

end


function startRadian_edit_Callback(hObject, ~, handles)
% hObject    handle to startRadian_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startRadian_edit as text
%        str2double(get(hObject,'String')) returns contents of startRadian_edit as a double

setBoundField(handles.output, 'startRadian', str2double(get(hObject, 'String')));

end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, ~, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
    if ~isfield(handles, 'closeFromOk')
        clearAllFields(handles);
    elseif ~handles.closeFromOk
        clearAllFields(handles);
    end
    
    delete(hObject);
end


% --- Executes on button press in resetLabelsFile_pushbutton.
function resetLabelsFile_pushbutton_Callback(~, ~, handles)
% hObject    handle to resetLabelsFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setBoundField(handles.output, 'labelsFile', '');
end


% --- Executes on button press in resetColorsFile_pushbutton.
function resetColorsFile_pushbutton_Callback(~, ~, handles)
% hObject    handle to resetColorsFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setBoundField(handles.output, 'colorsFile', '');
end

function resetSizesFile_pushbutton_Callback(~, ~, handles)
% hObject    handle to resetSizesFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setBoundField(handles.output, 'sizesFile', '');
end

function resetEdgeMatrixFile_pushbutton_Callback(~, ~, handles)
% hObject    handle to resetEdgeMatrixFile_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setBoundField(handles.output, 'edgeMatrixFile', '');
end


% --- Executes on selection change in edgeMatrixColormap_popupmenu.
function edgeMatrixColormap_popupmenu_Callback(hObject, ~, handles)
% hObject    handle to edgeMatrixColormap_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns edgeMatrixColormap_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from edgeMatrixColormap_popupmenu
    contents = cellstr(get(hObject, 'String'));
    index = get(hObject, 'value');
    if index > 1
        colorscheme = contents{index};
        setBoundField(handles.output, 'edgeMatrixColorscheme', colorscheme);
    else
        setBoundField(handles.output, 'edgeMatrixColorscheme', '');
    end
end


% --- Executes during object creation, after setting all properties.
function edgeMatrixColormap_popupmenu_CreateFcn(hObject, ~, ~)
% hObject    handle to edgeMatrixColormap_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
prepForWindowsOs(hObject);
set(hObject, 'String', ['Select Color Scheme' utils.colorMapNames]);
end


% --- Executes on selection change in nodeColorsColormap_popupmenu.
function nodeColorsColormap_popupmenu_Callback(hObject, ~, handles)
% hObject    handle to nodeColorsColormap_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns nodeColorsColormap_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from nodeColorsColormap_popupmenu

    contents = cellstr(get(hObject, 'String'));
    index = get(hObject, 'value');
    if index > 1
        colorscheme = contents{index};
        setBoundField(handles.output, 'nodeColorsColorscheme', colorscheme);
    else
        setBoundField(handles.output, 'nodeColorsColorscheme', '');
    end
end


% --- Executes during object creation, after setting all properties.
function nodeColorsColormap_popupmenu_CreateFcn(hObject, ~, ~)
% hObject    handle to nodeColorsColormap_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
prepForWindowsOs(hObject);
set(hObject, 'String', ['Select Color Scheme' utils.colorMapNames]);
end
