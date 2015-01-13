function setNodeSizes(v, sizesFullPath)
v.nodeSizes = fileUtils.circro.loadSizes(sizesFullPath);
guidata(v.hMainFigure,v)
drawing.drawCircle(v);
