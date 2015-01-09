function AddCircularDiagram_Callback(obj, ~)

    files = {};
    function fn = setFile(field)
        function setterFn(f)
            files.(field) = f;
        end
        fn = @setterFn;
    end

    h = gui.circularDiagram.filesSelection(...
        setFile('labels'), setFile('sizes'), setFile('edgeMatrix'), setFile('colors'));
    waitfor(h);
    commands.addCircularDiagram(guidata(obj), files.labels);
end