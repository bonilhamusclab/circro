function varargout = Circro(varargin)
clear all
mOutputArgs = {}; % Variable for storing output when GUI returns
h = findall(0,'tag',mfilename); %run as singleton
if (isempty(h)) % new instance
   h = makeGUI(); %set up user interface
else % instance already running
   figure(h);  %Figure exists so bring Figure to the focus
end
if (nargin) && (ischar(varargin{1})) 
 f = str2func(varargin{1});
 f(guidata(h),varargin{2:nargin})
end
mOutputArgs{1} = h;% return handle to main figure
if nargout>0
 [varargout{1:nargout}] = mOutputArgs{:};
end
%end Circro

% --- Declare and create all the user interface objects
function [vFig] = makeGUI()
sz = [980 680]; % figure width, height in pixels
screensize = get(0,'ScreenSize');
margin = [ceil((screensize(3)-sz(1))/2) ceil((screensize(4)-sz(2))/2)];
v.hMainFigure = figure('MenuBar','none','Toolbar','none','HandleVisibility','on', ...
  'position',[margin(1), margin(2), sz(1), sz(2)], ... 
    'Tag', mfilename,'Name', mfilename, 'NumberTitle','off', ...
 'Color', [1 1 1]);
set(v.hMainFigure,'Renderer','OpenGL')
v.hAxes = axes('Parent', v.hMainFigure,'HandleVisibility','on','Units', 'normalized','Position',[0.0 0.0 1 1]); %important: turn ON visibility
%menus...
v.hFileMenu = uimenu('Parent',v.hMainFigure,'HandleVisibility','callback','Label','File');
v.hAddMenu = uimenu('Parent',v.hFileMenu,'Label','Select list of nodes','HandleVisibility','callback', 'Callback', @Add_nodes_Callback); % to open the list of nodes

v.hEditMenu = uimenu('Parent',v.hMainFigure,'HandleVisibility','callback','Label','Edit');
v.hCopyMenu = uimenu('Parent',v.hEditMenu,'Label','Copy','HandleVisibility','callback','Callback', @CopyMenu_Callback);
v.hFunctionMenu = uimenu('Parent',v.hMainFigure,'HandleVisibility','callback','Label','Functions');
v.hToolbarMenu = uimenu('Parent',v.hFunctionMenu,'Label','Show/hide toolbar','HandleVisibility','callback','Callback', @ToolbarMenu_Callback);
v.hToolbarMenu = uimenu('Parent',v.hFunctionMenu,'Label','Select values','HandleVisibility','callback','Callback', @Add_sizes_Callback);
v.hToolbarMenu = uimenu('Parent',v.hFunctionMenu,'Label','Select colors','HandleVisibility','callback','Callback', @Add_colors_Callback);
v.hToolbarMenu = uimenu('Parent',v.hFunctionMenu,'Label','Select matrix','HandleVisibility','callback','Callback', @Add_matrix_Callback);
v.hSaveBmpMenu = uimenu('Parent',v.hFileMenu,'Label','Save bitmap','HandleVisibility','callback', 'Callback', @SaveBmpMenu_Callback);

v.hHelpMenu = uimenu('Parent',v.hMainFigure,'HandleVisibility','callback','Label','Help');
v.hAboutMenu = uimenu('Parent',v.hHelpMenu,'Label','About','HandleVisibility','callback','Callback', @AboutMenu_Callback);

%viewing preferences - color, material, camera position, light position
v.vprefs.demoObjects = true; %denote simulated objects
v.vprefs.colors = [0.7 0.7 0.9 0.6; 1 0 0 0.7; 0 1 0 0.7; 0 0 1 0.7; 0.5 0.5 0 0.7; 0.5 0 0.5 0.7; 0 0.5 0.5 0.7]; %rgba for each layer
v.vprefs.materialKaKdKsn = [0.6 0.4 0.4, 100.0];%ambient/diffuse/specular strength and specular exponent
v.vprefs.bgMode = 0; %background mode: wireframe, faces, faces+edges
v.vprefs.backFaceLighting = 1;
v.vprefs.azLight = 0; %light azimuth relative to camera
v.vprefs.elLight = 60; %light elevation relative to camera
v.vprefs.camLight = [];
v.vprefs.az = 45; %camera azimuth
v.vprefs.el = 10; %camera elevation
v.vprefs.color = [1 1 1]  ; %camera elevation
guidata(v.hMainFigure,v);%store settings
vFig = v.hMainFigure;
%end makeGUI()

% Callback functions
% --- add a circle with default options
function Add_nodes_Callback(obj, eventdat)
v=guidata(obj);
SelectFileToOpen(v);
v=guidata(obj);
list_regions=v.list_regions;
v.number_region=numel(list_regions); 
draw_circle(list_regions,v); % write circle with the regions listed
fprintf('Drawing circle with %d regions\n',numel(list_regions))
write_names(list_regions,1.2,pi/2);
%end Add_nodes_Callback()

% --- show/hide figure toolbar
function ToolbarMenu_Callback(obj, eventdata)
if strcmpi(get(gcf, 'Toolbar'),'none')
    set(gcf,  'Toolbar', 'figure');
else
    set(gcf,  'Toolbar', 'none');
end
%end ToolbarMenu_Callback()

% --- save screenshot as bitmap image
function SaveBmpMenu_Callback(obj, eventdata)
v=guidata(obj);
[file,path] = uiputfile('*.png','Save image as');
if isequal(file,0), return; end;
saveBitmap(v,[path file]);
%end SaveBmpMenu_Callback()

% --- add a circle with default options
function Add_sizes_Callback(obj, eventdat)
v=guidata(obj);
Select_size_data(v);
v=guidata(obj);
value_sizes=v.value_sizes;
num_value_size=numel(value_sizes);
list_value_sizes(1:num_value_size/2,2)=flipud(((num_value_size/2)+1:num_value_size)'); % here in case I decide to add display values in the future
if isfield(v,'list_regions')
    list_regions=v.list_regions; % nodes were previously selected
else
    temp=[(1:num_value_size/2)' flipud((((num_value_size/2)+1):num_value_size)')]; % nodes were not previously selected- assigning names
    list_regions=(num2cell(temp));
end
value_sizes=v.value_sizes;
draw_circle(list_regions,v,value_sizes);
fprintf('Drawing circle with %d regions\n',numel(list_regions))
if exist('list_regions','var')
    write_names(list_regions,(1+max(value_sizes(:))),pi/2);
end
%end Add_sizes_Callback()

% --- Add colors
function Add_colors_Callback(obj, eventdat)
v=guidata(obj);
Select_colors_data(v);
v=guidata(obj);
value_colors=v.value_colors;
num_value_colors=numel(value_colors);
size_value_colors=size(value_colors);
list_value_colors(1:num_value_colors/2,2)=flipud(((num_value_colors/2)+1:num_value_colors)'); % here in case I decide to add display values in the future
if isfield(v,'list_regions')
    list_regions=v.list_regions; % nodes were previously selected
else
    temp=[(1:num_value_colors/2)' flipud((((num_value_colors/2)+1):num_value_colors)')]; % nodes were not previously selected- assigning names
    list_regions=(num2cell(temp));
end
value_colors=v.value_colors;
fprintf('Drawing circle with %d regions\n',numel(value_colors))
if isfield(v,'value_sizes')
    value_sizes=v.value_sizes;
    draw_circle(list_regions,v,value_sizes); %sizes were previously selected
else
    draw_circle(list_regions,v,(ones(size_value_colors))/4,value_colors)
end
if exist('list_regions','var')
    write_names(list_regions,(1+max(value_colors(:))),pi/2);
end
% end Add colors;

% --- Add matrix
function Add_matrix_Callback(obj, eventdat)
v=guidata(obj);
Select_matrix_data(v);
v=guidata(obj);
matrix=v.matrix;
number_links=size(matrix,1);
% check if list regions previously defined
if isfield(v,'list_regions')
    list_regions=v.list_regions; % nodes were previously selected
else
    temp=[(1:number_links/2)' flipud((((number_links/2)+1):number_links)')]; % nodes were not previously selected- assigning names
    list_regions=(num2cell(temp));
end
% check if sizes previously defined
if isfield(v,'value_sizes')
    value_sizes=v.list_regions; % nodes were previously selected
else
    temp=[(1:num_value_colors/2)' flipud((((num_value_colors/2)+1):num_value_colors)')]; % nodes were not previously selected- assigning names
    list_regions=(num2cell(temp));
end

draw_links(matrix,threshold,start_radian,radius)
%%


% --- open files with nodes
function SelectFileToOpen(v)
%filename: mesh (GIFTI,VTK,PLY) or NIFTI voxel image to open
% thresh : (NIFTI only) isosurface threshold Inf for automatic, -Inf for dialog input
% reduce : (NIFTI only) path reduction ratio, e.g. 0.2 makes mesh 20% original size
% smooth : (NIFTI only) radius of smoothing, 0 = no smoothing
    
    [list_filename, list_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    'Select a text file');
    if isequal(list_filename,0), return; end;
    
    [~, list_regions]=xlsread([list_pathname list_filename]);
    v.list_regions=list_regions;
    guidata(v.hMainFigure,v)
   
% --- creates renderings
function draw_circle(list_regions,v,sizes,colors,colorscheme)
axis square
delete(allchild(v.hAxes));%
set(v.hMainFigure,'CurrentAxes',v.hAxes)
set(0, 'CurrentFigure', v.hMainFigure);  %# for figures
    n=(size(list_regions,1)*(size(list_regions,2)));
    if nargin<3;
        % set constants
        r = 1;  % sets the outer radius
        list_sizes(1:n,1)=r*1.1; % sets the inner radius as 0.9 of R
    else
        r = 1;
        list_sizes(1:n/2,1)=sizes(1:end,1);
        list_sizes(1:n/2,2)=flipud(sizes(1:end,2));% flip the second column for sequential drawing of segments
        list_sizes=list_sizes+r;
    end
    if nargin>=4
        list_colors(1:n/2,1)=colors(1:end,1);
        list_colors(1:n/2,2)=flipud(colors(1:end,2));
        list_colors=[list_colors(1:n/2,1);list_colors(1:n/2,2)]; % organized into one single column 
       
    else
        list_colors=rand(n,1);
        list_colors(n/2,1)=0.5;% set the mid value as on (to set the color as the mid-value
    end
    if nargin<5
        colorscheme=hot;
    end
    start_radian=pi/2; %sets the origin of the first segment (could also be 0)
    end_radian=start_radian+(2*pi)/n; %sets the end of the first segment (could also be pi/2)
    % end constants
    
    axis square        
    for segment=1:n % draw the circle
        % map colors
        color=find_color_in_colorscheme(list_colors(segment),list_colors,colorscheme);           
        draw_segment(start_radian,end_radian,list_sizes(segment),r,color,[])
        start_radian=end_radian;
        end_radian=start_radian+(2*pi)/n;
        pause(0.01)
        hold on        
    end
    % add colorbar
    colormap(colorscheme)
    cb=colorbar;
    cbIm = findobj(cb,'Type','image');
    alpha(cbIm,0.5)
    % end add colorbar      
    R=max(list_sizes(:));
    axis([-2.3*R 2.3*R -2.3*R 2.3*R])
    axis square
    axis off

function draw_segment(start,term,R,r,color,height)
    
    seg = linspace( start, term, 100);
    %outer rim
    if isempty(height)
        height=0;
    end
    x_1 = (R+height)*cos(seg) ;
    y_1 = (R+height)*sin(seg) ;
    %inner rim
    x_2 = r*cos(seg) ;
    y_2 = r*sin(seg) ;
    % flip inner rim
    x_2=flipdim(x_2,2);
    y_2=flipdim(y_2,2);
    X=[x_1 x_2];
    Y=[y_1 y_2];
    pol=fill(X,Y,'r');    
    if ~isempty(color)
        set(pol,'FaceColor',color)
    end
    set(pol,'EdgeColor','k')
    set(pol,'FaceAlpha',0.4)
%end draw segment

function write_names(list_regions,radius,start_radian)
    regions=[list_regions(:,1);flipud(list_regions(:,2))]; % flip right hemisphere regions
    number_regions=size(regions,1);
    for i=1:number_regions        
        theta=  ( (start_radian + ( (i-1) *(2*pi/number_regions) ))...
            + (start_radian + ( (i *(2*pi/number_regions) )) ))/2 ;       
        x = radius * cos(theta);
        y = radius * sin(theta);        
        if ischar(regions{i})
            name=regions{i};
        else
            name=num2str(regions{i});
        end        
        text(x*(1.1), y*(1.1), name, 'HorizontalAlignment','center','FontSize',10)               
    end    
% end write names

function Select_size_data(v)
[sizes_filename, sizes_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    'Select a text file');
    if isequal(sizes_filename,0), return; end;
    [value_sizes, ~]=xlsread([sizes_pathname sizes_filename]);
    v.value_sizes=value_sizes;       
    guidata(v.hMainFigure,v)
% end Select_size_data

function Select_colors_data(v)
[colors_filename, colors_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    'Select a text file');
    if isequal(colors_filename,0), return; end;
    [value_colors, ~]=xlsread([colors_pathname colors_filename]);
    v.value_colors=value_colors;     
    guidata(v.hMainFigure,v)
% end select colors data

function Select_matrix_data(v)
[matrix_filename, matrix_pathname] = uigetfile( ...
                    {'*.xlsx;', 'excel files (*.xlsx)';...
                    '*.xls;', 'excel files (*.xls)'; ...
                    '*.*',       'All Files (*.*)'},...
                    'Select a text file');
    if isequal(matrix_filename,0), return; end;
    [matrix, ~]=xlsread([matrix_pathname matrix_filename]);
    v.matrix=matrix;     
    guidata(v.hMainFigure,v)

% --- Save screenshot as bitmap image
function saveBitmap(v,varargin)
% inputs: filename
%MATcro('saveBitmap',{'myPicture.png'});
if (length(varargin) < 1), return; end;
filename = char(varargin{1});
%saveas(v.hAxes, filename,'png'); %<- save as 150dpi
print (v.hMainFigure, '-r600', '-dpng', filename); %<- save as 600dpi , '-noui'
%end saveBitmap()

% find value associated with a color
function color=find_color_in_colorscheme(value,range,colorscheme)
    cm_length=size(colorscheme,1); % length of the colormap
    cmin=min(range); % min
    cmax=max(range); % max
    csteps=linspace(cmin,cmax,cm_length); % incremental steps from min to max within the length of the colormap
    C_index = ( abs(value-csteps) == min(abs(value-csteps)) ); % find the closest step to value
    color=colorscheme(C_index,:); % color associated with value     
%end find_color_in_colorscheme

function draw_links(matrix,threshold,start_radian,radius)
%%
    number_links=size(matrix,1);

    links=triu(matrix>threshold);%# this is a random list of connections
    [ind1,ind2]=ind2sub(size(links),find(links(:)));
    
    for i=1:size(ind1,1);
        if ind1(i)~=ind2(i)
            
           theta_ind1=  ( (start_radian + ( (ind1(i)-1) *(2*pi/number_links) ))...
               + (start_radian + ( (ind1(i)) *(2*pi/number_links) )) )/2;
           theta_ind2=  ( (start_radian + ( (ind2(i)-1) *(2*pi/number_links) ))...
               + (start_radian + ( (ind2(i)) *(2*pi/number_links) )) )/2;
                             
           if theta_ind1>theta_ind2
                larger_theta=theta_ind1;
                smaller_theta=theta_ind2;
            else
                larger_theta=theta_ind2;
                smaller_theta=theta_ind1;
            end

            if larger_theta-smaller_theta<pi

                arc=linspace(smaller_theta,larger_theta,3);
                inter_theta=(arc(2));
            else
                temp_theta=smaller_theta+(2*pi);
                arc=linspace(larger_theta,temp_theta,3);
                inter_theta=(arc(2));
            end
            
            x_1 = radius * cos(theta_ind1);
            y_1 = radius * sin(theta_ind1);
            
            x_2 = radius * cos(theta_ind2);
            y_2 = radius * sin(theta_ind2);

            distance= sqrt(( x_2-x_1 )^2  + ( y_2-y_1 )^2);

            if distance>=2*radius;
                elevation=radius/2;
            end

            if distance<2*radius
               elevation=radius-(distance/2);
            end

            x_inter = elevation * (cos(inter_theta)) ;
            y_inter = elevation * (sin(inter_theta)) ;
 
            a=[x_1;x_inter;x_2]'; % xs
            b=[y_1;y_inter;y_2]'; % ys

            xx = pi*(0:1:2); 

            yy=[a;b];

            pp = spline(xx,yy);
            yyy = ppval(pp, linspace(0,2*pi,100));
            plot(yyy(1,:),yyy(2,:),'color',[0.5 0.5 0.5],'linewidth',1.5*matrix(ind1(i),ind2(i)) ) %,yy(1,2:3),yy(2,2:3),'or'), axis equal

            %pause(0.8)
        end

    end
% end draw links




    