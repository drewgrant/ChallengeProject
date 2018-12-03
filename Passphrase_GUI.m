function varargout = Passphrase_GUI(varargin)
% PASSPHRASE_GUI MATLAB code for Passphrase_GUI.fig
%      PASSPHRASE_GUI, by itself, creates a new PASSPHRASE_GUI or raises the existing
%      singleton*.
%
%      H = PASSPHRASE_GUI returns the handle to a new PASSPHRASE_GUI or the handle to
%      the existing singleton*.
%
%      PASSPHRASE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PASSPHRASE_GUI.M with the given input arguments.
%
%      PASSPHRASE_GUI('Property','Value',...) creates a new PASSPHRASE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Passphrase_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Passphrase_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Passphrase_GUI

% Last Modified by GUIDE v2.5 07-Nov-2018 13:22:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Passphrase_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Passphrase_GUI_OutputFcn, ...
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


% --- Executes just before Passphrase_GUI is made visible.
function Passphrase_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Passphrase_GUI (see VARARGIN)

% Choose default command line output for Passphrase_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Passphrase_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);





% --- Outputs from this function are returned to the command line.
function varargout = Passphrase_GUI_OutputFcn(hObject, eventdata, handles) 
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
nasal = record(2, 'new_rec.wav', 20000);
[y,fs] = audioread('new_rec.wav');
soundsc(y,fs);
disp('Your new recording is playing!')
h = uicontrol('Style','text','String','New Phrase');
set ( gcf, 'Color', [1 1 1] )

 


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
authentic = authenticate(3, 'new_rec.wav');
if authentic == 1
    disp('Access Granted!')
    h = uicontrol('Style','text','String','GRANTED');
    set ( gcf, 'Color', [0 1 0] )
else
    disp('Access Denied!')
    h = uicontrol('Style','text','String','DENIED');
    set ( gcf, 'Color', [1 0 0] )
end


