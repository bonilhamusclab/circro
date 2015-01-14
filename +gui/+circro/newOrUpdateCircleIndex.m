function circleIndex = newOrUpdateCircleIndex(v, msg)
%set circleIndex to 1 if none rendered yet, else ask user if renedering a 
%new circle or updating a current one is desired

circleIndex = 1;
if isfield(v, 'circles') && ~isempty(v.circles)
    createNew = createNewOrUpdateQuestSub();
    if createNew < 0 %Cancelled
        circleIndex = -1;
        return;
    elseif createNew
        circleIndex = length(v.circles) + 1;
    else %update
        circleIndex = gui.circro.promptCircleIndex(v, msg);
    end
end

end

function createNew = createNewOrUpdateQuestSub()
    question = 'Render node colors as new diagram or update current diagram?';
    title = 'Create New Or Update';
    answer = questdlg(question, title, 'New', 'Update', 'Update');
    createNew = strcmpi(answer, 'new');
    if strcmpi(answer, 'cancel')
        createNew = -1;
    end
end
