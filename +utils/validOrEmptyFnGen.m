function fn = validOrEmptyFnGen(validStrings, funcName, varName)
    function validOrEmpty(stringInput)
        if ~isempty(stringInput)
            validatestring(stringInput, validStrings, funcName, varName);
        end
    end
    fn = @validOrEmpty;
end