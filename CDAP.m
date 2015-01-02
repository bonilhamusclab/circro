function varargout = CDAP(varargin)
% CDAP MATLAB code for CDAP.fig
%      CDAP, by itself, creates a new CDAP or raises the existing
%      singleton*.
%
%      H = CDAP returns the handle to a new CDAP or the handle to
%      the existing singleton*.
%
%      CDAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CDAP.M with the given input arguments.
%
%      CDAP('Property','Value',...) creates a new CDAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CDAP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CDAP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CDAP

% Last Modified by GUIDE v2.5 03-Oct-2013 14:52:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CDAP_OpeningFcn, ...
                   'gui_OutputFcn',  @CDAP_OutputFcn, ...
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


% --- Executes just before CDAP is made visible.
function CDAP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CDAP (see VARARGIN)

% Choose default command line output for CDAP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CDAP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CDAP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Sizes.
function Sizes_Callback(hObject, eventdata, handles)
% hObject    handle to Sizes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Colors.
function Colors_Callback(hObject, eventdata, handles)
% hObject    handle to Colors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Matrix.
function Matrix_Callback(hObject, eventdata, handles)
% hObject    handle to Matrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in test.
function test_Callback(hObject, eventdata, handles)
% hObject    handle to test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    bla=figure;
    if isfield (handles, 'data') && ~isfield (handles.data, 'title_plot')
        
        title_plot=handles.data.title_plot;
        title(title_plot)
    end
    
    
    
    handles.data.bla=bla;
    guidata(hObject,handles)


% --- Executes on button press in test_close.
function test_close_Callback(hObject, eventdata, handles)
% hObject    handle to test_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    bla=handles.data.bla
    close(bla)



function title_Callback(hObject, eventdata, handles)
% hObject    handle to title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of title as text
%        str2double(get(hObject,'String')) returns contents of title as a double


    title_plot=get(hObject,'String');
    handles.data.title_plot=title_plot;
    guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
