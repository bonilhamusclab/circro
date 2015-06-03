function SetEdgeThreshold_Callback(obj, ~)
    v=guidata(obj);

    if ~isfield(v, 'circles')
        noEdgesToThresholdPopUpSub();
        return;
    end

    availableIndexes = find(cellfun(@(c) isfield(c, 'edgeMatrix'), v.circles));

    if isempty(availableIndexes)
        noEdgesToThresholdPopUpSub()
        return;
    end


    circleIndex = gui.circro.promptCircleIndex(v, 'edge threshold', availableIndexes);
    if circleIndex < 1
        return;
    end

    edgeThreshold = '';
    function setThreshold(value)
        edgeThreshold = value;
    end

    circleState = circro.utils.circro.getCircleState(v.circles{circleIndex});
    currentEdgeThreshold = circleState.edgeThreshold;

    f = gui.circro.edgeThresholdPrompt(v.circles{circleIndex}.edgeMatrix, ...
        @setThreshold, currentEdgeThreshold);
    uiwait(f);

    if ~isempty(edgeThreshold)
        Circro('circro.setEdgeThreshold', edgeThreshold, circleIndex);
    end
end

function noEdgesToThresholdPopUpSub()
    msgbox('No Diagrams available with edges to threshold');
end