%%Command History%%
% Circro('circro.setNodeLabels','/Users/john/projects/musc_lab/circro_matlab/circro/data/labels.xlsx',1);
% Circro('circro.setNodeSizes','/Users/john/projects/musc_lab/circro_matlab/circro/data/sizes.xlsx',1);
% Circro('circro.setNodeColors','/Users/john/projects/musc_lab/circro_matlab/circro/data/colors.xlsx',2,'jet');
% Circro('circro.toggleLabels',2);
% Circro('circro.setDimensions',0.7,0.8,1.5708,2);
% Circro('circro.setEdgeMatrix','/Users/john/projects/musc_lab/circro_matlab/circro/data/matrix.xlsx',0.96,'copper',2);
% Circro('circro.setNodeColors','/Users/john/projects/musc_lab/circro_matlab/circro/data/colors.xlsx',1,'hot');
% Circro('circro.setNodeColors','/Users/john/projects/musc_lab/circro_matlab/circro/data/colors.xlsx',3,'bone');
% Circro('circro.toggleLabels',3);
%Circro('circro.setDimensions',0.85,0.85,1.5708,3);
%%%%

Circro('circro.setNodeLabels','data/labels.xlsx',1);
Circro('circro.setNodeSizes','data/sizes.xlsx',1);
Circro('circro.setNodeColors','data/colors.xlsx',2,'jet');
Circro('circro.toggleLabels',2);
Circro('circro.setDimensions',0.7,0.8,1.5708,2);
Circro('circro.setEdgeMatrix','data/matrix.xlsx',0.96,'copper',2);
Circro('circro.setNodeColors','data/colors.xlsx',1,'hot');
Circro('circro.setNodeColors','data/colors.xlsx',3,'bone');
Circro('circro.toggleLabels',3);
Circro('circro.setDimensions',0.85,0.85,1.5708,3);
Circro('circro.setEdgeThreshold',0.92,2);