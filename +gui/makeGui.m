% --- Declare and create all the user interface objects
function [vFig] = makeGui()
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
v.hSaveBmpMenu = uimenu('Parent',v.hFileMenu,'Label','Save bitmap','HandleVisibility','callback', 'Callback', @gui.SaveBmpMenu_Callback);
v.hFileCircoMenu = uimenu(v.hFileMenu, 'Label', 'Circro');
v.hFileCircoAddMenu = uimenu('Parent',v.hFileCircoMenu,'Label','Add Diagram','HandleVisibility','callback', 'Callback', @gui.circro.AddDiagram_Callback); % to open the list of nodes
v.hFileCircoCloseMenu = uimenu('Parent',v.hFileCircoMenu,'Label','Close Diagrams','HandleVisibility','callback', 'Callback', @gui.circro.CloseDiagrams_Callback); % to open the list of nodes

v.hEditMenu = uimenu('Parent',v.hMainFigure,'HandleVisibility','callback','Label','Edit');
v.hCopyMenu = uimenu('Parent',v.hEditMenu,'Label','Copy','HandleVisibility','callback','Callback', @gui.CopyMenu_Callback);
v.hFunctionMenu = uimenu('Parent',v.hMainFigure,'HandleVisibility','callback','Label','Functions');
v.hToolbarMenu = uimenu('Parent',v.hFunctionMenu,'Label','Show/hide toolbar','HandleVisibility','callback','Callback', @gui.ToolbarMenu_Callback);
v.hFunctionCircroMenu = uimenu(v.hFunctionMenu, 'Label', 'Circro');
v.hFunctionCircroSetNodeLabelsMenu = uimenu(v.hFunctionCircroMenu,'Label','Set/Add Node Labels','HandleVisibility','callback','Callback', @gui.circro.SetNodeLabels_Callback);
v.hFunctionCircroSetNodeColorsMenu = uimenu(v.hFunctionCircroMenu,'Label','Set/Add Node Colors','HandleVisibility','callback','Callback', @gui.circro.SetNodeColors_Callback);
v.hFunctionCircroSetNodeSizesMenu = uimenu(v.hFunctionCircroMenu,'Label','Set/Add Node Sizes','HandleVisibility','callback','Callback', @gui.circro.SetNodeSizes_Callback);
v.hFunctionCircroSetEdgeMatrixMenu = uimenu(v.hFunctionCircroMenu,'Label','Set/Add Edge Matrix','HandleVisibility','callback','Callback', @gui.circro.SetEdgeMatrix_Callback);
v.hFunctionCircroSetDimensionsMenu = uimenu(v.hFunctionCircroMenu,'Label','Set Dimensions','HandleVisibility','callback','Callback', @gui.circro.SetDimensions_Callback);
v.hFunctionCircroSetEdgeThresholdMenu = uimenu(v.hFunctionCircroMenu,'Label','Set Edge Threshold','HandleVisibility','callback','Callback', @gui.circro.SetEdgeThreshold_Callback);


v.hHelpMenu = uimenu('Parent',v.hMainFigure,'HandleVisibility','callback','Label','Help');
v.hAboutMenu = uimenu('Parent',v.hHelpMenu,'Label','About','HandleVisibility','callback','Callback', @gui.AboutMenu_Callback);

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
%end makeGui()
