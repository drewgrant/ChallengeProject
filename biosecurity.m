function varargout = biosecurity(varargin)
    % BIOSECURITY MATLAB code for biosecurity.fig
    %      BIOSECURITY, by itself, creates a new BIOSECURITY or raises the existing
    %      singleton*.
    %
    %      H = BIOSECURITY returns the handle to a new BIOSECURITY or the handle to
    %      the existing singleton*.
    %
    %      BIOSECURITY('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in BIOSECURITY.M with the given input arguments.
    %
    %      BIOSECURITY('Property','Value',...) creates a new BIOSECURITY or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before biosecurity_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to biosecurity_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help biosecurity

    % Last Modified by GUIDE v2.5 05-Nov-2018 01:31:03

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @biosecurity_OpeningFcn, ...
                       'gui_OutputFcn',  @biosecurity_OutputFcn, ...
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

% --- Executes just before biosecurity is made visible.
function biosecurity_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to biosecurity (see VARARGIN)

    % Choose default command line output for biosecurity
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes biosecurity wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
    
    handles.data.registration = false;
    handles.data.key = [];
    handles.data.launchtime = tic;
    guidata( hObject, handles );
end

% --- Outputs from this function are returned to the command line.
function varargout = biosecurity_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)


    try
        [y,fs] = audioread('new_rec.wav');
        soundsc(y,fs);
        audiowrite('key.wav', y,fs);
        disp('Your new recording is playing!')
        set ( gcf, 'Color', [1 1 1] )
        handles.data.key = register();
        handles.data.registration = true;
        handles.text2.String{2} = 'SYSTEM LOCKED';
        guidata( hObject, handles );
    catch e
        handles.data.registration = false;
        handles.text2.String{2} = 'NO KEY REGISTERED';
        guidata( hObject, handles );
        rethrow( e );
    end
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton2 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    if handles.data.registration
        if compare( handles.data.key )
            handles.text2.String{2} = 'ACCESS GRANTED';
            handles.text2.ForegroundColor = 'green';
            fprintf( 'ACCESS GRANTED (%.4f sec)\n', toc( handles.data.launchtime ) );
        else
            handles.text2.String{2} = 'ACCESS DENIED';
            handles.text2.ForegroundColor = 'red';
            fprintf( 'ACCESS DENIED (%.4f sec)\n', toc( handles.data.launchtime ) );
        end
        guidata( hObject, handles );
        pause( 2 );
        try
            handles.text2.String{2} = 'SYSTEM LOCKED';
            handles.text2.ForegroundColor = 'black';
            guidata( hObject, handles );
        catch
            % skip, we just closed the GUI
        end
    end
end