function varargout = Preprocess_data(varargin)
% PREPROCESS_DATA MATLAB code for Preprocess_data.fig
%      PREPROCESS_DATA, by itself, creates a new PREPROCESS_DATA or raises the existing
%      singleton*.
%
%      H = PREPROCESS_DATA returns the handle to a new PREPROCESS_DATA or the handle to
%      the existing singleton*.
%
%      PREPROCESS_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREPROCESS_DATA.M with the given input arguments.
%
%      PREPROCESS_DATA('Property','Value',...) creates a new PREPROCESS_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Preprocess_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Preprocess_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Preprocess_data

% Last Modified by GUIDE v2.5 20-Feb-2020 10:42:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Preprocess_data_OpeningFcn, ...
                   'gui_OutputFcn',  @Preprocess_data_OutputFcn, ...
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


% --- Executes just before Preprocess_data is made visible.
function Preprocess_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Preprocess_data (see VARARGIN)

% Choose default command line output for Preprocess_data
handles.output = hObject;
axes(handles.axes1); axis off

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Preprocess_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Preprocess_data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a;global I3;

I=rgb2gray(a);
axes(handles.axes1); imshow(I); title('Gray Image');
pause(1);
I2 = imtophat(I,strel('disk',15));
I3 = histeq(I2);
axes(handles.axes1); imshow(I3);title('Increase the Image Contrast');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('segment_data.m');
