function circleIndex = promptCircleIndex(v, msg, availableIndices)
%function circleIndex = promptCircleIndex(v, msg, availableIndices)
%prompts for circle index if more than 1 circle is present, 
% else it does not prompt
% returns -1 if no circles are yet rendered

    maxCircleIndex = utils.circro.maxCircleIndex(v);
    
    if nargin < 3
        availableIndices = [1:maxCircleIndex];
    end
    
    if maxCircleIndex > 1
        maxCircleIndex = max(availableIndices);
        circleIndex = promptIndexSub(availableIndices, maxCircleIndex, msg);
    else
        if any(availableIndices == 1)
            circleIndex = maxCircleIndex; %could be -1 if no circles rendered
        else
            circleIndex = -1;
        end
    end 
end

function circleIndex = promptIndexSub(availableIndices, maxCircleIndex, msg)
    prompt = {['Circle Index (' num2str(availableIndices) ')']};
    name = ['Enter Circle Index For ' msg];
    numLines = 1;
    default = {num2str(maxCircleIndex)};

    answer = inputdlg(prompt, name, numLines, default);
    if isempty(answer), circleIndex = -1; return;
    else
        circleIndex = round(str2double(answer));
        validateattributes(circleIndex, {'numeric'}, ...
            {'integer', 'positive'});
        if ~any(availableIndices == circleIndex)
            msgbox(['Circle Index must be one of: ' num2str(availableIndices) ...
                ', but was: ' num2str(circleIndex)]);
            circleIndex = -1;
        end
    end
end
