function EchoHistory_Callback(obj, ~)
    v = guidata(obj);
    if isfield(v, 'history')
        
       history = v.history;
        
       if ~isempty(history)
            echoCommandsSub(history);
       else
           dispNoHistory();
       end
       
    else
        dispNoHistory();
    end
    
    function dispNoHistory()
        msgbox('No History recorded yet');
    end
end

function echoCommandsSub(history)
    fprintf('%%%%Command History%%%%\n')
    num_commands = length(history);
    for i = 1: num_commands
        command = 'Circro(';
        inputs = history(i);
        inputs = inputs{:};
            for j = 1 : length(inputs)
               input = inputs{j};
               if ischar(input)
                   command = [command '''' input ''',' ];
               else
                   command = [command sprintf('%g',input) ',' ];
               end
            end
        command(end) = ')'; %remove trailing comma with )
        fprintf('%s;\n', command); 
    end
    fprintf('%%%%%%%%\n')
end
