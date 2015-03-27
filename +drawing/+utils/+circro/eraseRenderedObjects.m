function eraseRenderedObjects(v)

delete(allchild(v.hAxes));


axesClass = 'matlab.graphics.axis.Axes';
f = v.hMainFigure;
%safer than a for loop as number of children change w/ each delete
childrenToDelete = logical(arrayfun(@(c) isa(c, axesClass) && c ~= v.hAxes, f.Children));
arrayfun(@delete, f.Children(childrenToDelete), 'UniformOutput', 0);