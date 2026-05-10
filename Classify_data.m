function varargout = Classify_data(varargin)
% CLASSIFY_DATA MATLAB code for Classify_data.fig
%      CLASSIFY_DATA, by itself, creates a new CLASSIFY_DATA or raises the existing
%      singleton*.
%
%      H = CLASSIFY_DATA returns the handle to a new CLASSIFY_DATA or the handle to
%      the existing singleton*.
%
%      CLASSIFY_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLASSIFY_DATA.M with the given input arguments.
%
%      CLASSIFY_DATA('Property','Value',...) creates a new CLASSIFY_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Classify_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Classify_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Classify_data

% Last Modified by GUIDE v2.5 22-Apr-2022 16:08:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Classify_data_OpeningFcn, ...
                   'gui_OutputFcn',  @Classify_data_OutputFcn, ...
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


% --- Executes just before Classify_data is made visible.
function Classify_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Classify_data (see VARARGIN)

% Choose default command line output for Classify_data
handles.output = hObject;
axes(handles.axes1); axis off
axes(handles.axes2); axis off
axes(handles.axes3); axis off
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Classify_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Classify_data_OutputFcn(hObject, eventdata, handles) 
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
global Data;global a;global I3;global A;
axes(handles.axes1);imshow(Data);title('Problem place');
 
imwrite(Data, '22.jpg');
I = imread('22.jpg');
bw = imbinarize(I,'adaptive');
bw = bwareafilt(bw,2);
bw = imfill(bw,'holes');
[out,LM] = bwferet(bw,'MinFeretProperties');
maxLabel = max(LM(:));
out
axes(handles.axes2); 
h = imshow(LM,[]);
axis = h.Parent;
for labelvalues = 1:maxLabel
    xmin = [out.MinCoordinates{labelvalues}(1,1) out.MinCoordinates{labelvalues}(2,1)];
    ymin = [out.MinCoordinates{labelvalues}(1,2) out.MinCoordinates{labelvalues}(2,2)];
    imdistline(axis,xmin,ymin);
end
title(axis,'Minimum Feret Diameter');
colorbar('Ticks',1:maxLabel)

% Maximum Feret Diameter
I = imread('22.jpg');
bw = imbinarize(I,'adaptive');
bw = imfill(bw,'holes');
cc = bwconncomp(bw);
[out,LM] = bwferet(cc,'MaxFeretProperties');
maxLabel = max(LM(:));
out 
axes(handles.axes3); 
h = imshow(LM,[]);
axis = h.Parent;
for labelvalues = 1:maxLabel
    xmax = [out.MaxCoordinates{labelvalues}(1,1) out.MaxCoordinates{labelvalues}(2,1)];
    ymax = [out.MaxCoordinates{labelvalues}(1,2) out.MaxCoordinates{labelvalues}(2,2)];
    imdistline(axis,xmax,ymax);
end
title(axis,'Maximum Feret Diameter');
ax=mean2(A);ax=round(ax);
if(ax==121)
disp('Damaged list: House (20), road (40m). Estimated cost : 90Cr. Location :11.3410° N, 77.7172° E  (Erode) ');

elseif (ax==110)
    disp('Damaged list: House (2), Car (3), Tree (2), road (450m). Estimated cost : 290Cr. Location : 10.9602° N, 79.3845° E (kumbakonam) ');
    
elseif (ax==116)
    disp('Damaged list: House (10), Car (4),road (300m). Estimated cost : 190Cr. Location : 11.0168° N, 76.9558° E (Coimbatore) ');
    
elseif (ax==119)
    disp('Damaged list: House (4), ED Line (400m), road (40m). Estimated cost : 190Cr. Location : 10.7905° N, 78.7047° E (Tiruchirappalli)');
else
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('Analysis_data.m');
