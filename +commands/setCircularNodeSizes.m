function setCircularNodeSizes(v, sizesFullPath)
v.nodeSizes = fileUtils.loadSizes(sizesFullPath);
guidata(v.hMainFigure,v)
drawing.drawCircle(v);