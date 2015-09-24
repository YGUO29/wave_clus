function varargout = wave_clus_aux4(varargin)
% WAVE_CLUS_AUX1 M-file for wave_clus_aux.fig
%      WAVE_CLUS_AUX, by itself, creates a new WAVE_CLUS_AUX or raises the existing
%      singleton*.
%
%      H = WAVE_CLUS_AUX returns the handle to a new WAVE_CLUS_AUX or the handle to
%      the existing singleton*.
%
%      WAVE_CLUS_AUX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WAVE_CLUS_AUX.M with the given input arguments.
%
%      WAVE_CLUS_AUX('Property','Value',...) creates a new WAVE_CLUS_AUX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wave_clus_aux_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wave_clus_aux_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help wave_clus_aux

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wave_clus_aux4_OpeningFcn, ...
                   'gui_OutputFcn',  @wave_clus_aux4_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before wave_clus_aux is made visible.
function wave_clus_aux4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wave_clus_aux (see VARARGIN)

% Choose default command line output for wave_clus_aux
handles.output = hObject;

set(handles.isi24_accept_button,'value',1);
set(handles.isi25_accept_button,'value',1);
set(handles.isi26_accept_button,'value',1);
set(handles.isi27_accept_button,'value',1);
set(handles.isi28_accept_button,'value',1);
set(handles.fix24_button,'value',0);
set(handles.fix25_button,'value',0);
set(handles.fix26_button,'value',0);
set(handles.fix27_button,'value',0);
set(handles.fix28_button,'value',0);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes wave_clus_aux wait for user response (see UIRESUME)
% uiwait(handles.wave_clus_aux);


% --- Outputs from this function are returned to the command line.
function varargout = wave_clus_aux4_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
h_fig5 = findobj(h_figs,'tag','wave_clus_aux5');
USER_DATA = get(h_fig,'UserData');
par = USER_DATA{1};

for i = 24:28
	si = num2str(i);
	set(eval(['handles.isi' si '_accept_button']),'value',1);
	set(eval(['handles.isi' si '_reject_button']),'value',0);
	set(eval(['handles.fix' si '_button']),'value',0);
	
	eval(['set(handles.isi' si '_nbins,''string'',par.nbins' si ');']);
	eval(['set(handles.isi' si '_bin_step,''string'',par.bin_step' si ');']);
	
	% That's for passing the fix button settings to plot_spikes.
	if eval(['get(handles.fix' si '_button,''value'')']) ==1     
		eval(['par.fix' si ' = 1;']);
	else
		eval(['par.fix' si ' = 0;']);
	end
end

USER_DATA{1} = par;
set(handles.wave_clus_aux4,'userdata',USER_DATA)
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
set(h_fig5,'userdata',USER_DATA)
plot_spikes_aux(handles,4)



% Change nbins
% -------------------------------------------------------------
function isi_nbins_Callback(hObject, eventdata, handles)
b_name = get(gcbo,'Tag');
cn = regexp(b_name, '\d+', 'match');
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
eval(['par.nbins' cn{1}  '= str2num(get(hObject, ''String''));']);
USER_DATA{1} = par;
set(handles.wave_clus_aux4,'userdata',USER_DATA);
draw_histograms(handles,  str2double(cn{1}),USER_DATA);

% Change bin steps
% --------------------------------------------------------------------
function isi_bin_step_Callback(hObject, eventdata, handles)
b_name = get(gcbo,'Tag');
cn = regexp(b_name, '\d+', 'match');
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
eval(['par.bin_step' cn{1}  '= str2num(get(hObject, ''String''));']);
USER_DATA{1} = par;
set(handles.wave_clus_aux4,'userdata',USER_DATA);
draw_histograms(handles, str2double(cn{1}),USER_DATA);

% Reject buttons

% --------------------------------------------------------------------
function isi_reject_button_Callback(hObject, eventdata, handles)
set(hObject,'value',1);
b_name = get(gcbo,'Tag');
cn = str2double(regexp(b_name, '\d+', 'match'));

eval(['set(handles.isi' int2str(cn) '_accept_button,''value'',0);'])
USER_DATA = get(handles.wave_clus_aux4,'userdata');
classes = USER_DATA{6};
classes(classes==cn)=0;
USER_DATA{6} = classes;
USER_DATA{9} = classes;
USER_DATA{15} = true;
h_figs = get(0,'children');

h_fig{1} = findobj(h_figs,'tag','wave_clus_figure');
h_fig{2} = findobj(h_figs,'tag','wave_clus_aux');
h_fig{3} = findobj(h_figs,'tag','wave_clus_aux2');
h_fig{4} = findobj(h_figs,'tag','wave_clus_aux1');
h_fig{5} = findobj(h_figs,'tag','wave_clus_aux3');
h_fig{6} = findobj(h_figs,'tag','wave_clus_aux5');
set(handles.wave_clus_aux4,'userdata',USER_DATA);

for h = h_fig
    set(h{1},'userdata',USER_DATA)
end

set(hObject,'value',0);
eval(['cla(handles.spikes' int2str(cn) ',''reset'');']);
eval(['cla(handles.isi' int2str(cn) ',''reset'');']);
eval(['set(handles.isi' int2str(cn) '_accept_button,''value'',1);']);



% FIX buttons
% --------------------------------------------------------
function fix24_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==24);
if get(handles.fix24_button,'value') ==1
    USER_DATA{43} = fix_class;
    par.fix24 = 1;
else
    USER_DATA{43} = [];
    par.fix24 = 0;
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
set(handles.wave_clus_aux4,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
% --------------------------------------------------------
function fix25_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==25);
if get(handles.fix25_button,'value') ==1
    USER_DATA{44} = fix_class;
    par.fix25 = 1;
else
    USER_DATA{44} = [];
    par.fix25 = 0;
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
set(handles.wave_clus_aux4,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
% --------------------------------------------------------
function fix26_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==26);
if get(handles.fix26_button,'value') ==1
    USER_DATA{45} = fix_class;
    par.fix26 = 1;
else
    USER_DATA{45} = [];
    par.fix26 = 0;
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
set(handles.wave_clus_aux4,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
% --------------------------------------------------------
function fix27_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==27);
if get(handles.fix27_button,'value') ==1
    USER_DATA{46} = fix_class;
    par.fix27 = 1;
else
    USER_DATA{46} = [];
    par.fix27 = 0;
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
set(handles.wave_clus_aux4,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)
% --------------------------------------------------------
function fix28_button_Callback(hObject, eventdata, handles)
USER_DATA = get(handles.wave_clus_aux4,'userdata');
par = USER_DATA{1};
classes = USER_DATA{6};
fix_class = find(classes==28);
if get(handles.fix28_button,'value') ==1
    USER_DATA{47} = fix_class;
    par.fix28 = 1;
else
    USER_DATA{47} = [];
    par.fix28 = 0;
end
USER_DATA{1} = par;
h_figs=get(0,'children');
h_fig = findobj(h_figs,'tag','wave_clus_figure');
h_fig1 = findobj(h_figs,'tag','wave_clus_aux');
h_fig2 = findobj(h_figs,'tag','wave_clus_aux1');
h_fig3 = findobj(h_figs,'tag','wave_clus_aux2');
h_fig4 = findobj(h_figs,'tag','wave_clus_aux3');
set(handles.wave_clus_aux4,'userdata',USER_DATA);
set(h_fig,'userdata',USER_DATA)
set(h_fig1,'userdata',USER_DATA)
set(h_fig2,'userdata',USER_DATA)
set(h_fig3,'userdata',USER_DATA)
set(h_fig4,'userdata',USER_DATA)

