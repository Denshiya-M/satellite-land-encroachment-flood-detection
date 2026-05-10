function varargout = segment_data(varargin)
% SEGMENT_DATA MATLAB code for segment_data.fig
%      SEGMENT_DATA, by itself, creates a new SEGMENT_DATA or raises the existing
%      singleton*.
%
%      H = SEGMENT_DATA returns the handle to a new SEGMENT_DATA or the handle to
%      the existing singleton*.
%
%      SEGMENT_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEGMENT_DATA.M with the given input arguments.
%
%      SEGMENT_DATA('Property','Value',...) creates a new SEGMENT_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before segment_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to segment_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help segment_data

% Last Modified by GUIDE v2.5 20-Feb-2020 10:43:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @segment_data_OpeningFcn, ...
                   'gui_OutputFcn',  @segment_data_OutputFcn, ...
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


% --- Executes just before segment_data is made visible.
function segment_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to segment_data (see VARARGIN)

% Choose default command line output for segment_data
handles.output = hObject;
axes(handles.axes1); axis off

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes segment_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = segment_data_OutputFcn(hObject, eventdata, handles) 
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
global a;global A;global Data;
 
ax=mean2(A);ax=round(ax);
if(ax==190)
    msgbox('Normal');
else
end
s=A;
num_iter = 10;
    delta_t = 1/7;
    kappa = 15;
    option = 2;
    inp = anisodiff(s,num_iter,delta_t,kappa,option);
    inp = uint8(inp);
    
inp=imresize(inp,[256,256]);
if size(inp,3)>1
    inp=rgb2gray(inp);
end
I3=inp;
sout=imresize(inp,[256,256]);
t0=60;
th=t0+((max(inp(:))+min(inp(:)))./2);
for i=1:1:size(inp,1)
    for j=1:1:size(inp,2)
        if inp(i,j)>th
            sout(i,j)=1;
        else
            sout(i,j)=0;
        end
    end
end
label=bwlabel(sout)
stats=regionprops(logical(sout),'Solidity','Area','BoundingBox');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.6;
max_area=max(area(high_dense_area));
Data_label=find(area==max_area);
Data=ismember(label,Data_label);

if max_area>100
else
msgbox('No Data!!','status');
% axes(handles.axes3); cla(handles.axes3); title(''); axis off
axes(handles.axes1); cla(handles.axes1); title(''); axis off
    return;
end
box = stats(Data_label);
wantedBox = box.BoundingBox;
dilationAmount = 5;
rad = floor(dilationAmount);
[r,c] = size(Data);
filledImage = imfill(Data, 'holes');

for i=1:r
   for j=1:c
       x1=i-rad;
       x2=i+rad;
       y1=j-rad;
       y2=j+rad;
       if x1<1
           x1=1;
       end
       if x2>r
           x2=r;
       end
       if y1<1
           y1=1;
       end
       if y2>c
           y2=c;
       end
       erodedImage(i,j) = min(min(filledImage(x1:x2,y1:y2)));
   end
end
DataOutline=Data;
DataOutline(erodedImage)=0;
rgb = inp(:,:,[1 1 1]);
red = rgb(:,:,1);
red(DataOutline)=255;
green = rgb(:,:,2);
green(DataOutline)=0;
blue = rgb(:,:,3);
blue(DataOutline)=0;
DataOutlineInserted(:,:,1) = red; 
DataOutlineInserted(:,:,2) = green; 
DataOutlineInserted(:,:,3) = blue; 
axes(handles.axes1); imshow(inp); title('Segmented Image');
hold on;rectangle('Position',wantedBox,'EdgeColor','y');hold off;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('Classify_data.m');
